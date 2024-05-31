-module(iotdb_api_insert_records).

-include("include/iotdb.hrl").
-include("include/iotdb_client_types.hrl").

%% API.
-export([make/2]).

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
    case
        filter_and_encode_values_list(
            MeasurementsList, DataTypeList, ValuesList, Timestamps, [], [], []
        )
    of
        {ok, MeasurementsList2, ValuesList2, Timestamps2} ->
            {ok, #tSInsertRecordsReq{
                sessionId = SessionId,
                prefixPaths = Devices,
                measurementsList = MeasurementsList2,
                valuesList = ValuesList2,
                timestamps = Timestamps2,
                isAligned = IsAligned
            }};
        Error ->
            Error
    end.

filter_and_encode_values_list(
    [Measurements | MeasurementsList],
    [Types | TypesList],
    [Values | ValuesList],
    [Timestamp | Timestamps],
    MAcc,
    VAcc,
    TAcc
) ->
    case filter_and_encode_values(Measurements, Types, Values, [], <<>>) of
        true ->
            filter_and_encode_values_list(
                MeasurementsList, TypesList, ValuesList, Timestamps, MAcc, VAcc, TAcc
            );
        {false, Measurements2, ValuesBin} ->
            filter_and_encode_values_list(
                MeasurementsList,
                TypesList,
                ValuesList,
                Timestamps,
                [Measurements2 | MAcc],
                [ValuesBin | VAcc],
                [Timestamp | TAcc]
            );
        Error ->
            Error
    end;
filter_and_encode_values_list([], [], [], [], MeasurementsList, ValuesList, Timestamps) ->
    {ok, lists:reverse(MeasurementsList), lists:reverse(ValuesList), lists:reverse(Timestamps)};
filter_and_encode_values_list(_, _, _, _, _, _, _) ->
    {error, invalid_data}.

filter_and_encode_values(
    [_Measurement | Measurements], [_Type | Types], [null | Values], MAcc, VAcc
) ->
    filter_and_encode_values(Measurements, Types, Values, MAcc, VAcc);
filter_and_encode_values(
    [Measurement | Measurements], [Type | Types], [Value | Values], MAcc, VAcc
) ->
    TypeNum = iotdb_utils:get_data_type_number(Type),
    VAcc2 = <<VAcc/binary, TypeNum:8>>,
    VAcc3 = append_value_into_binary(TypeNum, Value, VAcc2),
    filter_and_encode_values(Measurements, Types, Values, [Measurement | MAcc], VAcc3);
filter_and_encode_values([], [], [], [], _ValueBin) ->
    true;
filter_and_encode_values([], [], [], Measurements, ValuesBin) ->
    {false, lists:reverse(Measurements), ValuesBin};
filter_and_encode_values(_, _, _, _, _) ->
    {error, invalid_data}.

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
    <<Acc/binary, Len:32, Value/binary>>.
