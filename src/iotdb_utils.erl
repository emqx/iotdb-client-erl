-module(iotdb_utils).

-include("include/iotdb.hrl").
-include("include/iotdb_client_types.hrl").

%% API.
-export([get_data_type_number/1]).

get_data_type_number(<<"BOOLEAN">>) ->
    ?DATATYPE_BOOLEAN;
get_data_type_number(<<"INT32">>) ->
    ?DATATYPE_INT32;
get_data_type_number(<<"INT64">>) ->
    ?DATATYPE_INT64;
get_data_type_number(<<"FLOAT">>) ->
    ?DATATYPE_FLOAT;
get_data_type_number(<<"DOUBLE">>) ->
    ?DATATYPE_DOUBLE;
get_data_type_number(<<"TEXT">>) ->
    ?DATATYPE_TEXT.
