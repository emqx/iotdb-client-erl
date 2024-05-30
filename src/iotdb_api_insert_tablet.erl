-module(iotdb_api_insert_tablet).

-include("include/iotdb.hrl").
-include("include/iotdb_client_types.hrl").

%% API.
-export([make/2]).

-record(bitmap, {
    index = 0 :: non_neg_integer(),
    nulls = 0 :: non_neg_integer(),
    bits = [0] :: [non_neg_integer()]
}).

-type bitmap() :: #bitmap{}.

make(
    SessionId,
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
    #tSInsertTabletReq{
        sessionId = SessionId,
        prefixPath = DeviceId,
        measurements = Measurements,
        values = values_to_binary(DataTypes, Values),
        timestamps = timestamps_to_binary(Timestamps),
        types = types_to_enum(DataTypes),
        size = RowSize,
        isAligned = IsAligned
    }.

timestamps_to_binary(Timestamps) ->
    lists:foldr(
        fun(Timestamp, Acc) ->
            <<Acc/binary, Timestamp:64/big>>
        end,
        <<>>,
        Timestamps
    ).

types_to_enum(DataTypes) ->
    lists:map(fun iotdb_utils:get_data_type_number/1, DataTypes).

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
