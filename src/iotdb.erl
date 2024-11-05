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

-type address() :: #{
    hostname := binary(),
    port := pos_integer()
}.

-type state() ::
    #{
        client := thrift_client:tclient(),
        sessionId := non_neg_integer(),
        addresses := [address()],
        version := integer(),
        zoneId := binary(),
        username := binary(),
        password := binary() | function(),
        options := map()
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
init([Cfg0]) ->
    Cfg = normalize_config(Cfg0),
    InitState = maps:with([addresses, version, zoneId, username, password, options], Cfg),
    try_connect(InitState).

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
handle_call(ping, _From, #{sessionId := SessionId} = State) ->
    Req = #tSInsertRecordReq{
        sessionId = SessionId,
        prefixPath = <<>>,
        measurements = [],
        values = <<>>,
        timestamp = erlang:system_time(millisecond),
        isAligned = false
    },
    case timeout_safe_call_thrift(State, testInsertRecord, [Req]) of
        {ok, State1, Result} ->
            {reply, {ok, Result}, State1};
        {error, State1, Result} ->
            Reason = {shutdown, {ping_failed, Result}},
            {stop, Reason, {error, Result}, State1}
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

terminate(_Reason, #{sessionId := SessionId} = State) ->
    Req = #tSCloseSessionReq{sessionId = SessionId},
    _ = call_thrift(State, closeSession, [Req]),
    ok;
terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

call_thrift(#{client := Client} = State, Function, Args) ->
    {Client1, Res} = thrift_client:call(Client, Function, Args),
    State1 = State#{client := Client1},
    case Res of
        {ok, Result} when is_record(Result, tSStatus) ->
            check_status(Result, State1, Result);
        {ok, Result} ->
            check_status(erlang:element(2, Result), State1, Result);
        {error, Error} ->
            {error, State1, Error}
    end.

timeout_safe_call_thrift(State, Function, Args) ->
    case call_thrift(State, Function, Args) of
        {error, State1, Reason} when Reason =:= timeout; Reason =:= closed ->
            case try_connect(State1) of
                {ok, State2} ->
                    call_thrift(State2, Function, Args);
                {error, Error} ->
                    {error, State1, Error}
            end;
        Any ->
            Any
    end.

check_status(#tSStatus{code = Code}, State, Result) when Code =:= 200; Code =:= 400 ->
    {ok, State, Result};
check_status(#tSStatus{code = Code, message = Message}, State, _) ->
    {error, State, #{code => Code, message => Message}}.

do_api_call(
    State,
    Function,
    Req
) ->
    {Succ, State1, Result} = timeout_safe_call_thrift(State, Function, [Req]),
    {State1, {Succ, Result}}.

%% compatible with legacy configurations
normalize_config(#{host := Host, port := Port} = Cfg) ->
    Cfg1 = maps:without([host, port], Cfg),
    convert_options(Cfg1#{addresses => [#{hostname => Host, port => Port}]});
normalize_config(#{addresses := _} = Cfg) ->
    convert_options(Cfg).

convert_options(#{options := Options0} = Cfg) ->
    Options1 = Options0#{framed => true},
    Cfg#{options := maps:to_list(Options1)}.

try_connect(#{addresses := Addresses} = State) ->
    try_connect(Addresses, State, {error, <<"No Address">>}).

try_connect(
    [#{hostname := Host, port := Port} | Addresses],
    #{
        version := Version,
        zoneId := ZoneId,
        username := Username,
        password := Password,
        options := Options
    } = State,
    _
) ->
    case thrift_client_util:new(Host, Port, ?SERVICE, Options) of
        {ok, Client} ->
            OpenReq = #tSOpenSessionReq{
                client_protocol = Version,
                zoneId = ZoneId,
                username = Username,
                password = unwrap_password(Password)
            },
            case call_thrift(State#{client => Client}, openSession, [OpenReq]) of
                {ok, State1, Result} ->
                    #tSOpenSessionResp{sessionId = SessionId} = Result,
                    {ok, State1#{
                        sessionId => SessionId
                    }};
                {error, _, Error} ->
                    try_connect(Addresses, State, {error, Error})
            end;
        Error ->
            try_connect(Addresses, State, Error)
    end;
try_connect([], _Options, Error) ->
    Error.

unwrap_password(Fun) when is_function(Fun) ->
    Fun();
unwrap_password(Bin) when is_binary(Bin) ->
    Bin.
