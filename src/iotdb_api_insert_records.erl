-module(iotdb_api_insert_records).

-include("include/iotdb.hrl").
-include("include/iotdb_client_types.hrl").

%% API.
-export([make/2]).

-define(NULL_TYPE_NUM, -1).

make(
    SessionId,
    #{
        devices := Devices,
        measurements_list := MeasurementsList,
        data_types_list := DataTypeList,
        values_list := ValuesList,
        isAligned := IsAligned,
        timestamps := Timestamps
    }
) ->
    #tSInsertRecordsReq{
        sessionId = SessionId,
        prefixPaths = Devices,
        measurementsList = MeasurementsList,
        valuesList = values_list_to_binary(DataTypeList, ValuesList, []),
        timestamps = timestamps_to_binary(Timestamps),
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

values_list_to_binary([Types | TypesList], [Values | ValuesList], Acc) ->
    Bin = values_to_binary(Types, Values, <<>>),
    values_list_to_binary(TypesList, ValuesList, [Bin | Acc]);
values_list_to_binary([], [], Acc) ->
    lists:reverse(Acc).

values_to_binary([Type | Types], [Value | Values], Acc) ->
    TypeNum =
        case Value of
            null ->
                ?NULL_TYPE_NUM;
            _ ->
                iotdb_utils:get_data_type_number(Type)
        end,
    Acc2 = <<Acc/binary, TypeNum:8>>,
    Acc3 = append_value_into_binary(TypeNum, Value, Acc2),
    values_to_binary(Types, Values, Acc3);
values_to_binary([], [], Acc) ->
    Acc.

append_value_into_binary(?DATATYPE_BOOLEAN, Value, Acc) ->
    IntVal =
        case Value of
            true ->
                1;
            _ ->
                0
        end,
    <<Acc/binary, IntVal:8>>;
append_value_into_binary(?DATATYPE_INT32, Value, Acc) ->
    <<Acc/binary, Value:32>>;
append_value_into_binary(?DATATYPE_INT64, Value, Acc) ->
    <<Acc/binary, Value:64>>;
append_value_into_binary(?DATATYPE_FLOAT, Value, Acc) ->
    <<Acc/binary, Value:32/float>>;
append_value_into_binary(?DATATYPE_DOUBLE, Value, Acc) ->
    <<Acc/binary, Value:64/float>>;
append_value_into_binary(?DATATYPE_TEXT, Value, Acc) ->
    Len = erlang:byte_size(Value),
    <<Acc/binary, Len:32, Value/binary>>;
append_value_into_binary(?NULL_TYPE_NUM, _, Acc) ->
    Acc.
