-module(iotdb).

-behaviour(gen_server).

-include("include/iotdb_client_types.hrl").

%% API.
-export([start_link/0, start_link/1, stop/1]).

-export([insert/2]).

%% gen_server.
-export([
    init/1,
    handle_call/3,
    handle_cast/2,
    handle_info/2,
    terminate/2,
    code_change/3
]).

-define(DATATYPE_BOOLEAN, 0).
-define(DATATYPE_INT32, 1).
-define(DATATYPE_INT64, 2).
-define(DATATYPE_FLOAT, 3).
-define(DATATYPE_DOUBLE, 4).
-define(DATATYPE_TEXT, 5).
-define(DATATYPE_VECTOR, 6).
-define(DATATYPE_NULL_TYPE, 7).

-type state() ::
    #{
        client := thrift_client:tclient(),
        sessionId := non_neg_integer()
    }.

-record(bitmap, {
    index = 0 :: non_neg_integer(),
    nulls = 0 :: non_neg_integer(),
    bits = [0] :: [non_neg_integer()]
}).

-type bitmap() :: #bitmap{}.

-define(SERVICE, iotdb_IClientRPCService_thrift).

%% API.
-spec start_link() -> {ok, pid()}.
start_link() ->
    start_link([]).

start_link(Opts) ->
    gen_server:start_link(?MODULE, [Opts], []).

stop(Pid) ->
    gen_server:stop(Pid).

insert(Pid, Req) ->
    gen_server:call(Pid, {?FUNCTION_NAME, Req}).

%% gen_server.
init([
    #{
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
                zoneId = ZoneId, username = Username, password = Password
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

handle_call({insert, Req}, _From, State) ->
    {State2, Result} = do_insert(State, Req),
    {reply, Result, State2};
handle_call(_Request, _From, State) ->
    {reply, ignored, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

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

do_insert(
    #{client := Client, sessionId := SessionId} = State,
    #{
        deviceId := DeviceId,
        isAligned := IsAligned,
        measurements := Measurements,
        dtypes := DataTypes,
        values := Values,
        timestamps := Timestamps
    }
) ->
    RowSize = erlang:length(Timestamps),
    TSReq = #tSInsertTabletReq{
        sessionId = SessionId,
        prefixPath = DeviceId,
        measurements = Measurements,
        values = values_to_binary(DataTypes, Values),
        timestamps = timestamps_to_binary(Timestamps),
        types = types_to_enum(DataTypes),
        size = RowSize,
        isAligned = IsAligned
    },
    {Succ, Client2, Result} = call_thrift(Client, insertTablet, [TSReq]),
    {State#{client := Client2}, {Succ, Result}}.

timestamps_to_binary(Timestamps) ->
    lists:foldr(
        fun(Timestamp, Acc) ->
            <<Acc/binary, Timestamp:64/big>>
        end,
        <<>>,
        Timestamps
    ).

types_to_enum(DataTypes) ->
    lists:map(fun type_str_to_num/1, DataTypes).

type_str_to_num(<<"BOOLEAN">>) ->
    ?DATATYPE_BOOLEAN;
type_str_to_num(<<"INT32">>) ->
    ?DATATYPE_INT32;
type_str_to_num(<<"INT64">>) ->
    ?DATATYPE_INT64;
type_str_to_num(<<"FLOAT">>) ->
    ?DATATYPE_FLOAT;
type_str_to_num(<<"DOUBLE">>) ->
    ?DATATYPE_DOUBLE;
type_str_to_num(<<"TEXT">>) ->
    ?DATATYPE_TEXT.

values_to_binary(Types, Values) ->
    values_to_binary(Types, Values, [], <<>>).

values_to_binary([Type | Types], [Row | Values], Maps, Acc) ->
    Method = mk_pack_method(Type),
    BitMap = new_bitmap(),
    {BitMap2, Acc2} = pack_value_rows(Row, Method, BitMap, Acc),
    values_to_binary(Types, Values, [BitMap2 | Maps], Acc2);
values_to_binary([], [], Maps, Acc) ->
    Maps2 = lists:reverse(Maps),
    append_bitmap_to_binary(Maps2, Acc).

append_bitmap_to_binary(Maps, Bin) ->
    lists:foldl(
        fun
            (#bitmap{nulls = 0}, Acc) ->
                <<Acc/binary, 0:8>>;
            (#bitmap{bits = Bits0}, Acc) ->
                Bits = lists:reverse(Bits0),
                lists:foldl(
                    fun(Map, InAcc) ->
                        <<InAcc/binary, Map:8>>
                    end,
                    <<Acc/binary, 1:8>>,
                    Bits
                )
        end,
        Bin,
        Maps
    ).

pack_value_rows([Value | Rows], Method, BitMap, Acc) ->
    {BitMap2, Acc2} = Method(Value, BitMap, Acc),
    pack_value_rows(Rows, Method, BitMap2, Acc2);
pack_value_rows([], _Method, BitMap, Acc) ->
    {BitMap, Acc}.

mk_pack_method(Type) ->
    fun(RawVal, BitMap, Acc) ->
        pack_value(Type, RawVal, BitMap, Acc)
    end.

pack_value(<<"BOOLEAN">>, RawVal, BitMap, Acc) ->
    {Value, BitMap2} = get_value_by_type(<<"BOOLEAN">>, RawVal, BitMap),
    {BitMap2, <<Acc/binary, Value:8>>};
pack_value(<<"INT32">>, RawVal, BitMap, Acc) ->
    {Value, BitMap2} = get_value_by_type(<<"INT32">>, RawVal, BitMap),
    {BitMap2, <<Acc/binary, Value:32>>};
pack_value(<<"INT64">>, RawVal, BitMap, Acc) ->
    {Value, BitMap2} = get_value_by_type(<<"INT64">>, RawVal, BitMap),
    {BitMap2, <<Acc/binary, Value:64>>};
pack_value(<<"FLOAT">>, RawVal, BitMap, Acc) ->
    {Value, BitMap2} = get_value_by_type(<<"FLOAT">>, RawVal, BitMap),
    {BitMap2, <<Acc/binary, Value:32/float>>};
pack_value(<<"DOUBLE">>, RawVal, BitMap, Acc) ->
    {Value, BitMap2} = get_value_by_type(<<"DOUBLE">>, RawVal, BitMap),
    {BitMap2, <<Acc/binary, Value:64/float>>};
pack_value(<<"TEXT">>, RawVal, BitMap, Acc) ->
    {Value, BitMap2} = get_value_by_type(<<"TEXT">>, RawVal, BitMap),
    Len = erlang:byte_size(Value),
    {BitMap2, <<Acc/binary, Len:32, Value/binary>>}.

get_value_by_type(<<"TEXT">>, null, BitMap) ->
    {<<>>, mark_in_bitmap(true, BitMap)};
get_value_by_type(_, null, BitMap) ->
    {0, mark_in_bitmap(true, BitMap)};
get_value_by_type(<<"BOOLEAN">>, true, BitMap) ->
    {1, mark_in_bitmap(false, BitMap)};
get_value_by_type(<<"BOOLEAN">>, false, BitMap) ->
    {0, mark_in_bitmap(false, BitMap)};
get_value_by_type(_, Value, BitMap) ->
    {Value, mark_in_bitmap(false, BitMap)}.

-spec new_bitmap() -> bitmap().
new_bitmap() ->
    #bitmap{}.

mark_in_bitmap(IsNull, #bitmap{index = Index, nulls = Nulls, bits = [Map | Bits]} = BitMap) ->
    case IsNull of
        true ->
            Map2 = Map bor (1 bsl (Index rem 8)),
            advance_bitmap_index(BitMap#bitmap{bits = [Map2 | Bits], nulls = Nulls + 1});
        _ ->
            advance_bitmap_index(BitMap)
    end.

advance_bitmap_index(#bitmap{index = Index, bits = Bits} = BitMap) ->
    Index2 = Index + 1,
    case Index2 rem 8 of
        0 ->
            BitMap#bitmap{index = Index2, bits = [0 | Bits]};
        _ ->
            BitMap#bitmap{index = Index2}
    end.
