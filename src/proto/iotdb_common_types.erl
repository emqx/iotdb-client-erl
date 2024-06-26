%%
%% Autogenerated by Thrift Compiler (0.19.0)
%%
%% DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
%%

-module(iotdb_common_types).

-include("iotdb_common_types.hrl").

-export([struct_info/1, struct_info_ext/1, enum_info/1, enum_names/0, struct_names/0, exception_names/0]).

struct_info('tEndPoint') ->
  {struct, [{1, string},
          {2, i32}]}
;

struct_info('tSStatus') ->
  {struct, [{1, i32},
          {2, string},
          {3, {list, {struct, {'iotdb_common_types', 'tSStatus'}}}},
          {4, {struct, {'iotdb_common_types', 'tEndPoint'}}}]}
;

struct_info('tConsensusGroupId') ->
  {struct, [{1, i32},
          {2, i32}]}
;

struct_info('tSeriesPartitionSlot') ->
  {struct, [{1, i32}]}
;

struct_info('tTimePartitionSlot') ->
  {struct, [{1, i64}]}
;

struct_info('tRegionReplicaSet') ->
  {struct, [{1, {struct, {'iotdb_common_types', 'tConsensusGroupId'}}},
          {2, {list, {struct, {'iotdb_common_types', 'tDataNodeLocation'}}}}]}
;

struct_info('tNodeResource') ->
  {struct, [{1, i32},
          {2, i64}]}
;

struct_info('tConfigNodeLocation') ->
  {struct, [{1, i32},
          {2, {struct, {'iotdb_common_types', 'tEndPoint'}}},
          {3, {struct, {'iotdb_common_types', 'tEndPoint'}}}]}
;

struct_info('tDataNodeLocation') ->
  {struct, [{1, i32},
          {2, {struct, {'iotdb_common_types', 'tEndPoint'}}},
          {3, {struct, {'iotdb_common_types', 'tEndPoint'}}},
          {4, {struct, {'iotdb_common_types', 'tEndPoint'}}},
          {5, {struct, {'iotdb_common_types', 'tEndPoint'}}},
          {6, {struct, {'iotdb_common_types', 'tEndPoint'}}}]}
;

struct_info('tDataNodeConfiguration') ->
  {struct, [{1, {struct, {'iotdb_common_types', 'tDataNodeLocation'}}},
          {2, {struct, {'iotdb_common_types', 'tNodeResource'}}}]}
;

struct_info('tFlushReq') ->
  {struct, [{1, string},
          {2, {list, string}}]}
;

struct_info('tSettleReq') ->
  {struct, [{1, {list, string}}]}
;

struct_info('tSchemaNode') ->
  {struct, [{1, string},
          {2, byte}]}
;

struct_info('tSetTTLReq') ->
  {struct, [{1, {list, string}},
          {2, i64}]}
;

struct_info('tFile') ->
  {struct, [{1, string},
          {2, string}]}
;

struct_info('tFilesResp') ->
  {struct, [{1, {struct, {'iotdb_common_types', 'tSStatus'}}},
          {2, {list, {struct, {'iotdb_common_types', 'tFile'}}}}]}
;

struct_info(_) -> erlang:error(function_clause).

struct_info_ext('tEndPoint') ->
  {struct, [{1, required, string, 'ip', undefined},
          {2, required, i32, 'port', undefined}]}
;

struct_info_ext('tSStatus') ->
  {struct, [{1, required, i32, 'code', undefined},
          {2, optional, string, 'message', undefined},
          {3, optional, {list, {struct, {'iotdb_common_types', 'tSStatus'}}}, 'subStatus', []},
          {4, optional, {struct, {'iotdb_common_types', 'tEndPoint'}}, 'redirectNode', #'tEndPoint'{}}]}
;

struct_info_ext('tConsensusGroupId') ->
  {struct, [{1, required, i32, 'type', undefined},
          {2, required, i32, 'id', undefined}]}
;

struct_info_ext('tSeriesPartitionSlot') ->
  {struct, [{1, required, i32, 'slotId', undefined}]}
;

struct_info_ext('tTimePartitionSlot') ->
  {struct, [{1, required, i64, 'startTime', undefined}]}
;

struct_info_ext('tRegionReplicaSet') ->
  {struct, [{1, required, {struct, {'iotdb_common_types', 'tConsensusGroupId'}}, 'regionId', #'tConsensusGroupId'{}},
          {2, required, {list, {struct, {'iotdb_common_types', 'tDataNodeLocation'}}}, 'dataNodeLocations', []}]}
;

struct_info_ext('tNodeResource') ->
  {struct, [{1, required, i32, 'cpuCoreNum', undefined},
          {2, required, i64, 'maxMemory', undefined}]}
;

struct_info_ext('tConfigNodeLocation') ->
  {struct, [{1, required, i32, 'configNodeId', undefined},
          {2, required, {struct, {'iotdb_common_types', 'tEndPoint'}}, 'internalEndPoint', #'tEndPoint'{}},
          {3, required, {struct, {'iotdb_common_types', 'tEndPoint'}}, 'consensusEndPoint', #'tEndPoint'{}}]}
;

struct_info_ext('tDataNodeLocation') ->
  {struct, [{1, required, i32, 'dataNodeId', undefined},
          {2, required, {struct, {'iotdb_common_types', 'tEndPoint'}}, 'clientRpcEndPoint', #'tEndPoint'{}},
          {3, required, {struct, {'iotdb_common_types', 'tEndPoint'}}, 'internalEndPoint', #'tEndPoint'{}},
          {4, required, {struct, {'iotdb_common_types', 'tEndPoint'}}, 'mPPDataExchangeEndPoint', #'tEndPoint'{}},
          {5, required, {struct, {'iotdb_common_types', 'tEndPoint'}}, 'dataRegionConsensusEndPoint', #'tEndPoint'{}},
          {6, required, {struct, {'iotdb_common_types', 'tEndPoint'}}, 'schemaRegionConsensusEndPoint', #'tEndPoint'{}}]}
;

struct_info_ext('tDataNodeConfiguration') ->
  {struct, [{1, required, {struct, {'iotdb_common_types', 'tDataNodeLocation'}}, 'location', #'tDataNodeLocation'{}},
          {2, required, {struct, {'iotdb_common_types', 'tNodeResource'}}, 'resource', #'tNodeResource'{}}]}
;

struct_info_ext('tFlushReq') ->
  {struct, [{1, optional, string, 'isSeq', undefined},
          {2, optional, {list, string}, 'storageGroups', []}]}
;

struct_info_ext('tSettleReq') ->
  {struct, [{1, required, {list, string}, 'paths', []}]}
;

struct_info_ext('tSchemaNode') ->
  {struct, [{1, required, string, 'nodeName', undefined},
          {2, required, byte, 'nodeType', undefined}]}
;

struct_info_ext('tSetTTLReq') ->
  {struct, [{1, required, {list, string}, 'storageGroupPathPattern', []},
          {2, required, i64, 'tTL', undefined}]}
;

struct_info_ext('tFile') ->
  {struct, [{1, required, string, 'fileName', undefined},
          {2, required, string, 'file', undefined}]}
;

struct_info_ext('tFilesResp') ->
  {struct, [{1, required, {struct, {'iotdb_common_types', 'tSStatus'}}, 'status', #'tSStatus'{}},
          {2, required, {list, {struct, {'iotdb_common_types', 'tFile'}}}, 'files', []}]}
;

struct_info_ext(_) -> erlang:error(function_clause).

struct_names() ->
  ['tEndPoint', 'tSStatus', 'tConsensusGroupId', 'tSeriesPartitionSlot', 'tTimePartitionSlot', 'tRegionReplicaSet', 'tNodeResource', 'tConfigNodeLocation', 'tDataNodeLocation', 'tDataNodeConfiguration', 'tFlushReq', 'tSettleReq', 'tSchemaNode', 'tSetTTLReq', 'tFile', 'tFilesResp'].

enum_info('tConsensusGroupType') ->
  [
    {'configRegion', 0},
    {'dataRegion', 1},
    {'schemaRegion', 2}
  ];

enum_info('tRegionMigrateFailedType') ->
  [
    {'addPeerFailed', 0},
    {'removePeerFailed', 1},
    {'removeConsensusGroupFailed', 2},
    {'deleteRegionFailed', 3},
    {'createRegionFailed', 4}
  ];

enum_info('tAggregationType') ->
  [
    {'cOUNT', 0},
    {'aVG', 1},
    {'sUM', 2},
    {'fIRST_VALUE', 3},
    {'lAST_VALUE', 4},
    {'mAX_TIME', 5},
    {'mIN_TIME', 6},
    {'mAX_VALUE', 7},
    {'mIN_VALUE', 8},
    {'eXTREME', 9},
    {'cOUNT_IF', 10}
  ];

enum_info('trainingState') ->
  [
    {'pENDING', 0},
    {'rUNNING', 1},
    {'fINISHED', 2},
    {'fAILED', 3},
    {'dROPPING', 4}
  ];

enum_info('modelTask') ->
  [
    {'fORECAST', 0}
  ];

enum_info('evaluateMetric') ->
  [
    {'mSE', 0},
    {'mAE', 1},
    {'rMSE', 2}
  ];

enum_info(_) -> erlang:error(function_clause).

enum_names() ->
  ['tConsensusGroupType', 'tRegionMigrateFailedType', 'tAggregationType', 'trainingState', 'modelTask', 'evaluateMetric'].

exception_names() ->
  [].

