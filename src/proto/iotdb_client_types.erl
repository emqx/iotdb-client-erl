%%
%% Autogenerated by Thrift Compiler (0.19.0)
%%
%% DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
%%

-module(iotdb_client_types).

-include("iotdb_client_types.hrl").

-export([struct_info/1, struct_info_ext/1, enum_info/1, enum_names/0, struct_names/0, exception_names/0]).

struct_info('tSQueryDataSet') ->
  {struct, [{1, string},
          {2, {list, string}},
          {3, {list, string}}]}
;

struct_info('tSQueryNonAlignDataSet') ->
  {struct, [{1, {list, string}},
          {2, {list, string}}]}
;

struct_info('tSTracingInfo') ->
  {struct, [{1, {list, string}},
          {2, {list, i64}},
          {3, i32},
          {4, i32},
          {5, i32},
          {6, i32},
          {7, i64},
          {8, i32},
          {9, i64},
          {10, i32},
          {11, i32}]}
;

struct_info('tSExecuteStatementResp') ->
  {struct, [{1, {struct, {'iotdb_common_types', 'tSStatus'}}},
          {2, i64},
          {3, {list, string}},
          {4, string},
          {5, bool},
          {6, {list, string}},
          {7, {struct, {'iotdb_client_types', 'tSQueryDataSet'}}},
          {8, {struct, {'iotdb_client_types', 'tSQueryNonAlignDataSet'}}},
          {9, {map, string, i32}},
          {10, {list, string}},
          {11, {list, byte}},
          {12, {struct, {'iotdb_client_types', 'tSTracingInfo'}}},
          {13, {list, string}},
          {14, bool}]}
;

struct_info('tSOpenSessionResp') ->
  {struct, [{1, {struct, {'iotdb_common_types', 'tSStatus'}}},
          {2, i32},
          {3, i64},
          {4, {map, string, string}}]}
;

struct_info('tSOpenSessionReq') ->
  {struct, [{1, i32},
          {2, string},
          {3, string},
          {4, string},
          {5, {map, string, string}}]}
;

struct_info('tSCloseSessionReq') ->
  {struct, [{1, i64}]}
;

struct_info('tSExecuteStatementReq') ->
  {struct, [{1, i64},
          {2, string},
          {3, i64},
          {4, i32},
          {5, i64},
          {6, bool},
          {7, bool}]}
;

struct_info('tSExecuteBatchStatementReq') ->
  {struct, [{1, i64},
          {2, {list, string}}]}
;

struct_info('tSGetOperationStatusReq') ->
  {struct, [{1, i64},
          {2, i64}]}
;

struct_info('tSCancelOperationReq') ->
  {struct, [{1, i64},
          {2, i64}]}
;

struct_info('tSCloseOperationReq') ->
  {struct, [{1, i64},
          {2, i64},
          {3, i64}]}
;

struct_info('tSFetchResultsReq') ->
  {struct, [{1, i64},
          {2, string},
          {3, i32},
          {4, i64},
          {5, bool},
          {6, i64}]}
;

struct_info('tSFetchResultsResp') ->
  {struct, [{1, {struct, {'iotdb_common_types', 'tSStatus'}}},
          {2, bool},
          {3, bool},
          {4, {struct, {'iotdb_client_types', 'tSQueryDataSet'}}},
          {5, {struct, {'iotdb_client_types', 'tSQueryNonAlignDataSet'}}},
          {6, {list, string}},
          {7, bool}]}
;

struct_info('tSFetchMetadataResp') ->
  {struct, [{1, {struct, {'iotdb_common_types', 'tSStatus'}}},
          {2, string},
          {3, {list, string}},
          {4, string}]}
;

struct_info('tSFetchMetadataReq') ->
  {struct, [{1, i64},
          {2, string},
          {3, string}]}
;

struct_info('tSGetTimeZoneResp') ->
  {struct, [{1, {struct, {'iotdb_common_types', 'tSStatus'}}},
          {2, string}]}
;

struct_info('tSSetTimeZoneReq') ->
  {struct, [{1, i64},
          {2, string}]}
;

struct_info('tSInsertRecordReq') ->
  {struct, [{1, i64},
          {2, string},
          {3, {list, string}},
          {4, string},
          {5, i64},
          {6, bool}]}
;

struct_info('tSInsertStringRecordReq') ->
  {struct, [{1, i64},
          {2, string},
          {3, {list, string}},
          {4, {list, string}},
          {5, i64},
          {6, bool},
          {7, i64}]}
;

struct_info('tSInsertTabletReq') ->
  {struct, [{1, i64},
          {2, string},
          {3, {list, string}},
          {4, string},
          {5, string},
          {6, {list, i32}},
          {7, i32},
          {8, bool}]}
;

struct_info('tSInsertTabletsReq') ->
  {struct, [{1, i64},
          {2, {list, string}},
          {3, {list, {list, string}}},
          {4, {list, string}},
          {5, {list, string}},
          {6, {list, {list, i32}}},
          {7, {list, i32}},
          {8, bool}]}
;

struct_info('tSInsertRecordsReq') ->
  {struct, [{1, i64},
          {2, {list, string}},
          {3, {list, {list, string}}},
          {4, {list, string}},
          {5, {list, i64}},
          {6, bool}]}
;

struct_info('tSInsertRecordsOfOneDeviceReq') ->
  {struct, [{1, i64},
          {2, string},
          {3, {list, {list, string}}},
          {4, {list, string}},
          {5, {list, i64}},
          {6, bool}]}
;

struct_info('tSInsertStringRecordsOfOneDeviceReq') ->
  {struct, [{1, i64},
          {2, string},
          {3, {list, {list, string}}},
          {4, {list, {list, string}}},
          {5, {list, i64}},
          {6, bool}]}
;

struct_info('tSInsertStringRecordsReq') ->
  {struct, [{1, i64},
          {2, {list, string}},
          {3, {list, {list, string}}},
          {4, {list, {list, string}}},
          {5, {list, i64}},
          {6, bool}]}
;

struct_info('tSDeleteDataReq') ->
  {struct, [{1, i64},
          {2, {list, string}},
          {3, i64},
          {4, i64}]}
;

struct_info('tSCreateTimeseriesReq') ->
  {struct, [{1, i64},
          {2, string},
          {3, i32},
          {4, i32},
          {5, i32},
          {6, {map, string, string}},
          {7, {map, string, string}},
          {8, {map, string, string}},
          {9, string}]}
;

struct_info('tSCreateAlignedTimeseriesReq') ->
  {struct, [{1, i64},
          {2, string},
          {3, {list, string}},
          {4, {list, i32}},
          {5, {list, i32}},
          {6, {list, i32}},
          {7, {list, string}},
          {8, {list, {map, string, string}}},
          {9, {list, {map, string, string}}}]}
;

struct_info('tSRawDataQueryReq') ->
  {struct, [{1, i64},
          {2, {list, string}},
          {3, i32},
          {4, i64},
          {5, i64},
          {6, i64},
          {7, bool},
          {8, bool},
          {9, i64}]}
;

struct_info('tSLastDataQueryReq') ->
  {struct, [{1, i64},
          {2, {list, string}},
          {3, i32},
          {4, i64},
          {5, i64},
          {6, bool},
          {7, bool},
          {8, i64}]}
;

struct_info('tSAggregationQueryReq') ->
  {struct, [{1, i64},
          {2, i64},
          {3, {list, string}},
          {4, {list, i32}},
          {5, i64},
          {6, i64},
          {7, i64},
          {8, i64},
          {9, i32},
          {10, i64}]}
;

struct_info('tSCreateMultiTimeseriesReq') ->
  {struct, [{1, i64},
          {2, {list, string}},
          {3, {list, i32}},
          {4, {list, i32}},
          {5, {list, i32}},
          {6, {list, {map, string, string}}},
          {7, {list, {map, string, string}}},
          {8, {list, {map, string, string}}},
          {9, {list, string}}]}
;

struct_info('serverProperties') ->
  {struct, [{1, string},
          {2, {list, string}},
          {3, string},
          {4, i32},
          {5, string},
          {6, string},
          {7, i32},
          {8, i32},
          {9, i32},
          {10, bool},
          {11, string}]}
;

struct_info('tSSetSchemaTemplateReq') ->
  {struct, [{1, i64},
          {2, string},
          {3, string}]}
;

struct_info('tSCreateSchemaTemplateReq') ->
  {struct, [{1, i64},
          {2, string},
          {3, string}]}
;

struct_info('tSAppendSchemaTemplateReq') ->
  {struct, [{1, i64},
          {2, string},
          {3, bool},
          {4, {list, string}},
          {5, {list, i32}},
          {6, {list, i32}},
          {7, {list, i32}}]}
;

struct_info('tSPruneSchemaTemplateReq') ->
  {struct, [{1, i64},
          {2, string},
          {3, string}]}
;

struct_info('tSQueryTemplateReq') ->
  {struct, [{1, i64},
          {2, string},
          {3, i32},
          {4, string}]}
;

struct_info('tSQueryTemplateResp') ->
  {struct, [{1, {struct, {'iotdb_common_types', 'tSStatus'}}},
          {2, i32},
          {3, bool},
          {4, i32},
          {5, {list, string}}]}
;

struct_info('tSUnsetSchemaTemplateReq') ->
  {struct, [{1, i64},
          {2, string},
          {3, string}]}
;

struct_info('tSDropSchemaTemplateReq') ->
  {struct, [{1, i64},
          {2, string}]}
;

struct_info('tSyncIdentityInfo') ->
  {struct, [{1, string},
          {2, i64},
          {3, string},
          {4, string}]}
;

struct_info('tSyncTransportMetaInfo') ->
  {struct, [{1, string},
          {2, i64}]}
;

struct_info('tSBackupConfigurationResp') ->
  {struct, [{1, {struct, {'iotdb_common_types', 'tSStatus'}}},
          {2, bool},
          {3, string},
          {4, i32}]}
;

struct_info('tSConnectionInfo') ->
  {struct, [{1, string},
          {2, i64},
          {3, string},
          {4, i32}]}
;

struct_info('tSConnectionInfoResp') ->
  {struct, [{1, {list, {struct, {'iotdb_client_types', 'tSConnectionInfo'}}}}]}
;

struct_info(_) -> erlang:error(function_clause).

struct_info_ext('tSQueryDataSet') ->
  {struct, [{1, required, string, 'time', undefined},
          {2, required, {list, string}, 'valueList', []},
          {3, required, {list, string}, 'bitmapList', []}]}
;

struct_info_ext('tSQueryNonAlignDataSet') ->
  {struct, [{1, required, {list, string}, 'timeList', []},
          {2, required, {list, string}, 'valueList', []}]}
;

struct_info_ext('tSTracingInfo') ->
  {struct, [{1, required, {list, string}, 'activityList', []},
          {2, required, {list, i64}, 'elapsedTimeList', []},
          {3, optional, i32, 'seriesPathNum', undefined},
          {4, optional, i32, 'seqFileNum', undefined},
          {5, optional, i32, 'unSeqFileNum', undefined},
          {6, optional, i32, 'sequenceChunkNum', undefined},
          {7, optional, i64, 'sequenceChunkPointNum', undefined},
          {8, optional, i32, 'unsequenceChunkNum', undefined},
          {9, optional, i64, 'unsequenceChunkPointNum', undefined},
          {10, optional, i32, 'totalPageNum', undefined},
          {11, optional, i32, 'overlappedPageNum', undefined}]}
;

struct_info_ext('tSExecuteStatementResp') ->
  {struct, [{1, required, {struct, {'iotdb_common_types', 'tSStatus'}}, 'status', #'tSStatus'{}},
          {2, optional, i64, 'queryId', undefined},
          {3, optional, {list, string}, 'columns', []},
          {4, optional, string, 'operationType', undefined},
          {5, optional, bool, 'ignoreTimeStamp', undefined},
          {6, optional, {list, string}, 'dataTypeList', []},
          {7, optional, {struct, {'iotdb_client_types', 'tSQueryDataSet'}}, 'queryDataSet', #'tSQueryDataSet'{}},
          {8, optional, {struct, {'iotdb_client_types', 'tSQueryNonAlignDataSet'}}, 'nonAlignQueryDataSet', #'tSQueryNonAlignDataSet'{}},
          {9, optional, {map, string, i32}, 'columnNameIndexMap', #{}},
          {10, optional, {list, string}, 'sgColumns', []},
          {11, optional, {list, byte}, 'aliasColumns', []},
          {12, optional, {struct, {'iotdb_client_types', 'tSTracingInfo'}}, 'tracingInfo', #'tSTracingInfo'{}},
          {13, optional, {list, string}, 'queryResult', []},
          {14, optional, bool, 'moreData', undefined}]}
;

struct_info_ext('tSOpenSessionResp') ->
  {struct, [{1, required, {struct, {'iotdb_common_types', 'tSStatus'}}, 'status', #'tSStatus'{}},
          {2, required, i32, 'serverProtocolVersion',   0},
          {3, optional, i64, 'sessionId', undefined},
          {4, optional, {map, string, string}, 'configuration', #{}}]}
;

struct_info_ext('tSOpenSessionReq') ->
  {struct, [{1, required, i32, 'client_protocol',   2},
          {2, required, string, 'zoneId', undefined},
          {3, required, string, 'username', undefined},
          {4, optional, string, 'password', undefined},
          {5, optional, {map, string, string}, 'configuration', #{}}]}
;

struct_info_ext('tSCloseSessionReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined}]}
;

struct_info_ext('tSExecuteStatementReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, string, 'statement', undefined},
          {3, required, i64, 'statementId', undefined},
          {4, optional, i32, 'fetchSize', undefined},
          {5, optional, i64, 'timeout', undefined},
          {6, optional, bool, 'enableRedirectQuery', undefined},
          {7, optional, bool, 'jdbcQuery', undefined}]}
;

struct_info_ext('tSExecuteBatchStatementReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, {list, string}, 'statements', []}]}
;

struct_info_ext('tSGetOperationStatusReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, i64, 'queryId', undefined}]}
;

struct_info_ext('tSCancelOperationReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, i64, 'queryId', undefined}]}
;

struct_info_ext('tSCloseOperationReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, optional, i64, 'queryId', undefined},
          {3, optional, i64, 'statementId', undefined}]}
;

struct_info_ext('tSFetchResultsReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, string, 'statement', undefined},
          {3, required, i32, 'fetchSize', undefined},
          {4, required, i64, 'queryId', undefined},
          {5, required, bool, 'isAlign', undefined},
          {6, optional, i64, 'timeout', undefined}]}
;

struct_info_ext('tSFetchResultsResp') ->
  {struct, [{1, required, {struct, {'iotdb_common_types', 'tSStatus'}}, 'status', #'tSStatus'{}},
          {2, required, bool, 'hasResultSet', undefined},
          {3, required, bool, 'isAlign', undefined},
          {4, optional, {struct, {'iotdb_client_types', 'tSQueryDataSet'}}, 'queryDataSet', #'tSQueryDataSet'{}},
          {5, optional, {struct, {'iotdb_client_types', 'tSQueryNonAlignDataSet'}}, 'nonAlignQueryDataSet', #'tSQueryNonAlignDataSet'{}},
          {6, optional, {list, string}, 'queryResult', []},
          {7, optional, bool, 'moreData', undefined}]}
;

struct_info_ext('tSFetchMetadataResp') ->
  {struct, [{1, required, {struct, {'iotdb_common_types', 'tSStatus'}}, 'status', #'tSStatus'{}},
          {2, optional, string, 'metadataInJson', undefined},
          {3, optional, {list, string}, 'columnsList', []},
          {4, optional, string, 'dataType', undefined}]}
;

struct_info_ext('tSFetchMetadataReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, string, 'type', undefined},
          {3, optional, string, 'columnPath', undefined}]}
;

struct_info_ext('tSGetTimeZoneResp') ->
  {struct, [{1, required, {struct, {'iotdb_common_types', 'tSStatus'}}, 'status', #'tSStatus'{}},
          {2, required, string, 'timeZone', undefined}]}
;

struct_info_ext('tSSetTimeZoneReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, string, 'timeZone', undefined}]}
;

struct_info_ext('tSInsertRecordReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, string, 'prefixPath', undefined},
          {3, required, {list, string}, 'measurements', []},
          {4, required, string, 'values', undefined},
          {5, required, i64, 'timestamp', undefined},
          {6, optional, bool, 'isAligned', undefined}]}
;

struct_info_ext('tSInsertStringRecordReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, string, 'prefixPath', undefined},
          {3, required, {list, string}, 'measurements', []},
          {4, required, {list, string}, 'values', []},
          {5, required, i64, 'timestamp', undefined},
          {6, optional, bool, 'isAligned', undefined},
          {7, optional, i64, 'timeout', undefined}]}
;

struct_info_ext('tSInsertTabletReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, string, 'prefixPath', undefined},
          {3, required, {list, string}, 'measurements', []},
          {4, required, string, 'values', undefined},
          {5, required, string, 'timestamps', undefined},
          {6, required, {list, i32}, 'types', []},
          {7, required, i32, 'size', undefined},
          {8, optional, bool, 'isAligned', undefined}]}
;

struct_info_ext('tSInsertTabletsReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, {list, string}, 'prefixPaths', []},
          {3, required, {list, {list, string}}, 'measurementsList', []},
          {4, required, {list, string}, 'valuesList', []},
          {5, required, {list, string}, 'timestampsList', []},
          {6, required, {list, {list, i32}}, 'typesList', []},
          {7, required, {list, i32}, 'sizeList', []},
          {8, optional, bool, 'isAligned', undefined}]}
;

struct_info_ext('tSInsertRecordsReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, {list, string}, 'prefixPaths', []},
          {3, required, {list, {list, string}}, 'measurementsList', []},
          {4, required, {list, string}, 'valuesList', []},
          {5, required, {list, i64}, 'timestamps', []},
          {6, optional, bool, 'isAligned', undefined}]}
;

struct_info_ext('tSInsertRecordsOfOneDeviceReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, string, 'prefixPath', undefined},
          {3, required, {list, {list, string}}, 'measurementsList', []},
          {4, required, {list, string}, 'valuesList', []},
          {5, required, {list, i64}, 'timestamps', []},
          {6, optional, bool, 'isAligned', undefined}]}
;

struct_info_ext('tSInsertStringRecordsOfOneDeviceReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, string, 'prefixPath', undefined},
          {3, required, {list, {list, string}}, 'measurementsList', []},
          {4, required, {list, {list, string}}, 'valuesList', []},
          {5, required, {list, i64}, 'timestamps', []},
          {6, optional, bool, 'isAligned', undefined}]}
;

struct_info_ext('tSInsertStringRecordsReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, {list, string}, 'prefixPaths', []},
          {3, required, {list, {list, string}}, 'measurementsList', []},
          {4, required, {list, {list, string}}, 'valuesList', []},
          {5, required, {list, i64}, 'timestamps', []},
          {6, optional, bool, 'isAligned', undefined}]}
;

struct_info_ext('tSDeleteDataReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, {list, string}, 'paths', []},
          {3, required, i64, 'startTime', undefined},
          {4, required, i64, 'endTime', undefined}]}
;

struct_info_ext('tSCreateTimeseriesReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, string, 'path', undefined},
          {3, required, i32, 'dataType', undefined},
          {4, required, i32, 'encoding', undefined},
          {5, required, i32, 'compressor', undefined},
          {6, optional, {map, string, string}, 'props', #{}},
          {7, optional, {map, string, string}, 'tags', #{}},
          {8, optional, {map, string, string}, 'attributes', #{}},
          {9, optional, string, 'measurementAlias', undefined}]}
;

struct_info_ext('tSCreateAlignedTimeseriesReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, string, 'prefixPath', undefined},
          {3, required, {list, string}, 'measurements', []},
          {4, required, {list, i32}, 'dataTypes', []},
          {5, required, {list, i32}, 'encodings', []},
          {6, required, {list, i32}, 'compressors', []},
          {7, optional, {list, string}, 'measurementAlias', []},
          {8, optional, {list, {map, string, string}}, 'tagsList', []},
          {9, optional, {list, {map, string, string}}, 'attributesList', []}]}
;

struct_info_ext('tSRawDataQueryReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, {list, string}, 'paths', []},
          {3, optional, i32, 'fetchSize', undefined},
          {4, required, i64, 'startTime', undefined},
          {5, required, i64, 'endTime', undefined},
          {6, required, i64, 'statementId', undefined},
          {7, optional, bool, 'enableRedirectQuery', undefined},
          {8, optional, bool, 'jdbcQuery', undefined},
          {9, optional, i64, 'timeout', undefined}]}
;

struct_info_ext('tSLastDataQueryReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, {list, string}, 'paths', []},
          {3, optional, i32, 'fetchSize', undefined},
          {4, required, i64, 'time', undefined},
          {5, required, i64, 'statementId', undefined},
          {6, optional, bool, 'enableRedirectQuery', undefined},
          {7, optional, bool, 'jdbcQuery', undefined},
          {8, optional, i64, 'timeout', undefined}]}
;

struct_info_ext('tSAggregationQueryReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, i64, 'statementId', undefined},
          {3, required, {list, string}, 'paths', []},
          {4, required, {list, i32}, 'aggregations', []},
          {5, optional, i64, 'startTime', undefined},
          {6, optional, i64, 'endTime', undefined},
          {7, optional, i64, 'interval', undefined},
          {8, optional, i64, 'slidingStep', undefined},
          {9, optional, i32, 'fetchSize', undefined},
          {10, optional, i64, 'timeout', undefined}]}
;

struct_info_ext('tSCreateMultiTimeseriesReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, {list, string}, 'paths', []},
          {3, required, {list, i32}, 'dataTypes', []},
          {4, required, {list, i32}, 'encodings', []},
          {5, required, {list, i32}, 'compressors', []},
          {6, optional, {list, {map, string, string}}, 'propsList', []},
          {7, optional, {list, {map, string, string}}, 'tagsList', []},
          {8, optional, {list, {map, string, string}}, 'attributesList', []},
          {9, optional, {list, string}, 'measurementAliasList', []}]}
;

struct_info_ext('serverProperties') ->
  {struct, [{1, required, string, 'version', undefined},
          {2, required, {list, string}, 'supportedTimeAggregationOperations', []},
          {3, required, string, 'timestampPrecision', undefined},
          {4, undefined, i32, 'maxConcurrentClientNum', undefined},
          {5, optional, string, 'watermarkSecretKey', undefined},
          {6, optional, string, 'watermarkBitString', undefined},
          {7, optional, i32, 'watermarkParamMarkRate', undefined},
          {8, optional, i32, 'watermarkParamMaxRightBit', undefined},
          {9, optional, i32, 'thriftMaxFrameSize', undefined},
          {10, optional, bool, 'isReadOnly', undefined},
          {11, optional, string, 'buildInfo', undefined}]}
;

struct_info_ext('tSSetSchemaTemplateReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, string, 'templateName', undefined},
          {3, required, string, 'prefixPath', undefined}]}
;

struct_info_ext('tSCreateSchemaTemplateReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, string, 'name', undefined},
          {3, required, string, 'serializedTemplate', undefined}]}
;

struct_info_ext('tSAppendSchemaTemplateReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, string, 'name', undefined},
          {3, required, bool, 'isAligned', undefined},
          {4, required, {list, string}, 'measurements', []},
          {5, required, {list, i32}, 'dataTypes', []},
          {6, required, {list, i32}, 'encodings', []},
          {7, required, {list, i32}, 'compressors', []}]}
;

struct_info_ext('tSPruneSchemaTemplateReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, string, 'name', undefined},
          {3, required, string, 'path', undefined}]}
;

struct_info_ext('tSQueryTemplateReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, string, 'name', undefined},
          {3, required, i32, 'queryType', undefined},
          {4, optional, string, 'measurement', undefined}]}
;

struct_info_ext('tSQueryTemplateResp') ->
  {struct, [{1, required, {struct, {'iotdb_common_types', 'tSStatus'}}, 'status', #'tSStatus'{}},
          {2, required, i32, 'queryType', undefined},
          {3, optional, bool, 'result', undefined},
          {4, optional, i32, 'count', undefined},
          {5, optional, {list, string}, 'measurements', []}]}
;

struct_info_ext('tSUnsetSchemaTemplateReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, string, 'prefixPath', undefined},
          {3, required, string, 'templateName', undefined}]}
;

struct_info_ext('tSDropSchemaTemplateReq') ->
  {struct, [{1, required, i64, 'sessionId', undefined},
          {2, required, string, 'templateName', undefined}]}
;

struct_info_ext('tSyncIdentityInfo') ->
  {struct, [{1, required, string, 'pipeName', undefined},
          {2, required, i64, 'createTime', undefined},
          {3, required, string, 'version', undefined},
          {4, required, string, 'database', undefined}]}
;

struct_info_ext('tSyncTransportMetaInfo') ->
  {struct, [{1, required, string, 'fileName', undefined},
          {2, required, i64, 'startIndex', undefined}]}
;

struct_info_ext('tSBackupConfigurationResp') ->
  {struct, [{1, required, {struct, {'iotdb_common_types', 'tSStatus'}}, 'status', #'tSStatus'{}},
          {2, optional, bool, 'enableOperationSync', undefined},
          {3, optional, string, 'secondaryAddress', undefined},
          {4, optional, i32, 'secondaryPort', undefined}]}
;

struct_info_ext('tSConnectionInfo') ->
  {struct, [{1, required, string, 'userName', undefined},
          {2, required, i64, 'logInTime', undefined},
          {3, required, string, 'connectionId', undefined},
          {4, required, i32, 'type', undefined}]}
;

struct_info_ext('tSConnectionInfoResp') ->
  {struct, [{1, required, {list, {struct, {'iotdb_client_types', 'tSConnectionInfo'}}}, 'connectionInfoList', []}]}
;

struct_info_ext(_) -> erlang:error(function_clause).

struct_names() ->
  ['tSQueryDataSet', 'tSQueryNonAlignDataSet', 'tSTracingInfo', 'tSExecuteStatementResp', 'tSOpenSessionResp', 'tSOpenSessionReq', 'tSCloseSessionReq', 'tSExecuteStatementReq', 'tSExecuteBatchStatementReq', 'tSGetOperationStatusReq', 'tSCancelOperationReq', 'tSCloseOperationReq', 'tSFetchResultsReq', 'tSFetchResultsResp', 'tSFetchMetadataResp', 'tSFetchMetadataReq', 'tSGetTimeZoneResp', 'tSSetTimeZoneReq', 'tSInsertRecordReq', 'tSInsertStringRecordReq', 'tSInsertTabletReq', 'tSInsertTabletsReq', 'tSInsertRecordsReq', 'tSInsertRecordsOfOneDeviceReq', 'tSInsertStringRecordsOfOneDeviceReq', 'tSInsertStringRecordsReq', 'tSDeleteDataReq', 'tSCreateTimeseriesReq', 'tSCreateAlignedTimeseriesReq', 'tSRawDataQueryReq', 'tSLastDataQueryReq', 'tSAggregationQueryReq', 'tSCreateMultiTimeseriesReq', 'serverProperties', 'tSSetSchemaTemplateReq', 'tSCreateSchemaTemplateReq', 'tSAppendSchemaTemplateReq', 'tSPruneSchemaTemplateReq', 'tSQueryTemplateReq', 'tSQueryTemplateResp', 'tSUnsetSchemaTemplateReq', 'tSDropSchemaTemplateReq', 'tSyncIdentityInfo', 'tSyncTransportMetaInfo', 'tSBackupConfigurationResp', 'tSConnectionInfo', 'tSConnectionInfoResp'].

enum_info('tSProtocolVersion') ->
  [
    {'iOTDB_SERVICE_PROTOCOL_V1', 0},
    {'iOTDB_SERVICE_PROTOCOL_V2', 1},
    {'iOTDB_SERVICE_PROTOCOL_V3', 2}
  ];

enum_info('tSConnectionType') ->
  [
    {'tHRIFT_BASED', 0},
    {'mQTT_BASED', 1},
    {'iNTERNAL', 2}
  ];

enum_info(_) -> erlang:error(function_clause).

enum_names() ->
  ['tSProtocolVersion', 'tSConnectionType'].

exception_names() ->
  [].

