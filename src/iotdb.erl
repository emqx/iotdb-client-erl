-module(iotdb).

-behaviour(gen_server).

-include("include/iotdb_client_types.hrl").

%% API.
-export([start_link/1, stop/1]).

-export([insert_tablet/2, insert_records/2, ping/1]).

%% gen_server.
-export([
    init/1,
    handle_call/3,
    handle_cast/2,
    handle_info/2,
    terminate/2,
    code_change/3
]).

-type state() ::
    #{
        client := thrift_client:tclient(),
        sessionId := non_neg_integer()
    }.

-define(SERVICE, iotdb_IClientRPCService_thrift).

%% the first time to create a new schema in IotDB may take a lot of time
-define(CALL_TIMEOUT, timer:seconds(15)).
-define(SVR_CALL(Pid, Msg), gen_server:call(Pid, Msg, ?CALL_TIMEOUT)).

start_link(Opts) ->
    gen_server:start_link(?MODULE, [Opts], []).

stop(Pid) ->
    gen_server:stop(Pid).

insert_tablet(Pid, Req) ->
    ?SVR_CALL(Pid, {?FUNCTION_NAME, Req}).

insert_records(Pid, Req) ->
    ?SVR_CALL(Pid, {?FUNCTION_NAME, Req}).

ping(Pid) ->
    ?SVR_CALL(Pid, ?FUNCTION_NAME).

%% gen_server.
init([
    #{
        version := Version,
        host := Host,
        port := Port,
        zoneId := ZoneId,
        username := Username,
        options := Options0
    } = Cfg
]) ->
    Options1 = Options0#{framed => true},
    Options = maps:to_list(Options1),
    case thrift_client_util:new(Host, Port, ?SERVICE, Options) of
        {ok, Client} ->
            Password = maps:get(password, Cfg, undefined),
            OpenReq = #tSOpenSessionReq{
                client_protocol = Version,
                zoneId = ZoneId,
                username = Username,
                password = Password
            },
            case call_thrift(Client, openSession, [OpenReq]) of
                {ok, Client1, Result} ->
                    #tSOpenSessionResp{sessionId = SessionId} = Result,
                    State =
                        #{
                            client => Client1,
                            sessionId => SessionId
                        },
                    {ok, State};
                {error, _, Error} ->
                    {error, Error}
            end;
        Error ->
            Error
    end.

handle_call({insert_tablet, Req}, _From, #{sessionId := SessionId} = State) ->
    TsReq = iotdb_api_insert_tablet:make(SessionId, Req),
    {State2, Result} = do_api_call(State, insertTablet, TsReq),
    {reply, Result, State2};
handle_call({insert_records, Req}, _From, #{sessionId := SessionId} = State) ->
    case iotdb_api_insert_records:make(SessionId, Req) of
        {ok, TsReq} ->
            {State2, Result} = do_api_call(State, insertRecords, TsReq),
            {reply, Result, State2};
        Error ->
            {reply, Error, State}
    end;
handle_call(ping, _From, #{client := Client, sessionId := SessionId} = State) ->
    Req = #tSInsertRecordReq{
        sessionId = SessionId,
        prefixPath = <<>>,
        measurements = [],
        values = <<>>,
        timestamp = erlang:system_time(millisecond),
        isAligned = false
    },
    case call_thrift(Client, testInsertRecord, [Req]) of
        {ok, Client1, Result} ->
            {reply, {ok, Result}, State#{client := Client1}};
        {error, _, Result} ->
            Reason = {shutdown, {ping_failed, Result}},
            {stop, Reason, {error, Result}, State}
    end;
handle_call(Request, From, State) ->
    logger:error("iotdb got unexpected call: ~p, from: ~p", [Request, From]),
    {reply, ignored, State}.

handle_cast(Msg, State) ->
    logger:error("iotdb got unexpected cast: ~p", [Msg]),
    {noreply, State}.

handle_info(Info, State) ->
    logger:error("iotdb got unexpected info: ~p", [Info]),
    {noreply, State}.

terminate(_Reason, #{client := Client, sessionId := SessionId}) ->
    Req = #tSCloseSessionReq{sessionId = SessionId},
    _ = call_thrift(Client, closeSession, [Req]),
    ok;
terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

call_thrift(Client, Function, Args) ->
    {Client1, Res} = thrift_client:call(Client, Function, Args),
    case Res of
        {ok, Result} when is_record(Result, tSStatus) ->
            check_status(Result, Client1, Result);
        {ok, Result} ->
            check_status(erlang:element(2, Result), Client1, Result);
        {error, Error} ->
            {error, Client1, Error}
    end.

check_status(#tSStatus{code = Code}, Client, Result) when Code =:= 200 ->
    {ok, Client, Result};
check_status(#tSStatus{code = Code, message = Message}, Client, _) ->
    {error, Client, #{code => Code, message => Message}}.

do_api_call(
    #{client := Client} = State,
    Function,
    Req
) ->
    {Succ, Client2, Result} = call_thrift(Client, Function, [Req]),
    {State#{client := Client2}, {Succ, Result}}.
