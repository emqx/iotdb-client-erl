%%
%% Autogenerated by Thrift Compiler (0.19.0)
%%
%% DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
%%

-module(iotdb_IClientRPCService_thrift).
-behaviour(thrift_service).


-include("iotdb_IClientRPCService_thrift.hrl").

-export([struct_info/1, function_info/2, function_names/0]).

struct_info(_) -> erlang:error(function_clause).
%%% interface
% executeQueryStatementV2(This, Req)
function_info('executeQueryStatementV2', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSExecuteStatementReq'}}}]}
;
function_info('executeQueryStatementV2', reply_type) ->
  {struct, {'iotdb_client_types', 'tSExecuteStatementResp'}};
function_info('executeQueryStatementV2', exceptions) ->
  {struct, []}
;
% executeUpdateStatementV2(This, Req)
function_info('executeUpdateStatementV2', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSExecuteStatementReq'}}}]}
;
function_info('executeUpdateStatementV2', reply_type) ->
  {struct, {'iotdb_client_types', 'tSExecuteStatementResp'}};
function_info('executeUpdateStatementV2', exceptions) ->
  {struct, []}
;
% executeStatementV2(This, Req)
function_info('executeStatementV2', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSExecuteStatementReq'}}}]}
;
function_info('executeStatementV2', reply_type) ->
  {struct, {'iotdb_client_types', 'tSExecuteStatementResp'}};
function_info('executeStatementV2', exceptions) ->
  {struct, []}
;
% executeRawDataQueryV2(This, Req)
function_info('executeRawDataQueryV2', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSRawDataQueryReq'}}}]}
;
function_info('executeRawDataQueryV2', reply_type) ->
  {struct, {'iotdb_client_types', 'tSExecuteStatementResp'}};
function_info('executeRawDataQueryV2', exceptions) ->
  {struct, []}
;
% executeLastDataQueryV2(This, Req)
function_info('executeLastDataQueryV2', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSLastDataQueryReq'}}}]}
;
function_info('executeLastDataQueryV2', reply_type) ->
  {struct, {'iotdb_client_types', 'tSExecuteStatementResp'}};
function_info('executeLastDataQueryV2', exceptions) ->
  {struct, []}
;
% executeAggregationQueryV2(This, Req)
function_info('executeAggregationQueryV2', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSAggregationQueryReq'}}}]}
;
function_info('executeAggregationQueryV2', reply_type) ->
  {struct, {'iotdb_client_types', 'tSExecuteStatementResp'}};
function_info('executeAggregationQueryV2', exceptions) ->
  {struct, []}
;
% fetchResultsV2(This, Req)
function_info('fetchResultsV2', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSFetchResultsReq'}}}]}
;
function_info('fetchResultsV2', reply_type) ->
  {struct, {'iotdb_client_types', 'tSFetchResultsResp'}};
function_info('fetchResultsV2', exceptions) ->
  {struct, []}
;
% openSession(This, Req)
function_info('openSession', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSOpenSessionReq'}}}]}
;
function_info('openSession', reply_type) ->
  {struct, {'iotdb_client_types', 'tSOpenSessionResp'}};
function_info('openSession', exceptions) ->
  {struct, []}
;
% closeSession(This, Req)
function_info('closeSession', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSCloseSessionReq'}}}]}
;
function_info('closeSession', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('closeSession', exceptions) ->
  {struct, []}
;
% executeStatement(This, Req)
function_info('executeStatement', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSExecuteStatementReq'}}}]}
;
function_info('executeStatement', reply_type) ->
  {struct, {'iotdb_client_types', 'tSExecuteStatementResp'}};
function_info('executeStatement', exceptions) ->
  {struct, []}
;
% executeBatchStatement(This, Req)
function_info('executeBatchStatement', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSExecuteBatchStatementReq'}}}]}
;
function_info('executeBatchStatement', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('executeBatchStatement', exceptions) ->
  {struct, []}
;
% executeQueryStatement(This, Req)
function_info('executeQueryStatement', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSExecuteStatementReq'}}}]}
;
function_info('executeQueryStatement', reply_type) ->
  {struct, {'iotdb_client_types', 'tSExecuteStatementResp'}};
function_info('executeQueryStatement', exceptions) ->
  {struct, []}
;
% executeUpdateStatement(This, Req)
function_info('executeUpdateStatement', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSExecuteStatementReq'}}}]}
;
function_info('executeUpdateStatement', reply_type) ->
  {struct, {'iotdb_client_types', 'tSExecuteStatementResp'}};
function_info('executeUpdateStatement', exceptions) ->
  {struct, []}
;
% fetchResults(This, Req)
function_info('fetchResults', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSFetchResultsReq'}}}]}
;
function_info('fetchResults', reply_type) ->
  {struct, {'iotdb_client_types', 'tSFetchResultsResp'}};
function_info('fetchResults', exceptions) ->
  {struct, []}
;
% fetchMetadata(This, Req)
function_info('fetchMetadata', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSFetchMetadataReq'}}}]}
;
function_info('fetchMetadata', reply_type) ->
  {struct, {'iotdb_client_types', 'tSFetchMetadataResp'}};
function_info('fetchMetadata', exceptions) ->
  {struct, []}
;
% cancelOperation(This, Req)
function_info('cancelOperation', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSCancelOperationReq'}}}]}
;
function_info('cancelOperation', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('cancelOperation', exceptions) ->
  {struct, []}
;
% closeOperation(This, Req)
function_info('closeOperation', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSCloseOperationReq'}}}]}
;
function_info('closeOperation', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('closeOperation', exceptions) ->
  {struct, []}
;
% getTimeZone(This, SessionId)
function_info('getTimeZone', params_type) ->
  {struct, [{1, i64}]}
;
function_info('getTimeZone', reply_type) ->
  {struct, {'iotdb_client_types', 'tSGetTimeZoneResp'}};
function_info('getTimeZone', exceptions) ->
  {struct, []}
;
% setTimeZone(This, Req)
function_info('setTimeZone', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSSetTimeZoneReq'}}}]}
;
function_info('setTimeZone', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('setTimeZone', exceptions) ->
  {struct, []}
;
% getProperties(This)
function_info('getProperties', params_type) ->
  {struct, []}
;
function_info('getProperties', reply_type) ->
  {struct, {'iotdb_client_types', 'serverProperties'}};
function_info('getProperties', exceptions) ->
  {struct, []}
;
% setStorageGroup(This, SessionId, StorageGroup)
function_info('setStorageGroup', params_type) ->
  {struct, [{1, i64},
          {2, string}]}
;
function_info('setStorageGroup', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('setStorageGroup', exceptions) ->
  {struct, []}
;
% createTimeseries(This, Req)
function_info('createTimeseries', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSCreateTimeseriesReq'}}}]}
;
function_info('createTimeseries', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('createTimeseries', exceptions) ->
  {struct, []}
;
% createAlignedTimeseries(This, Req)
function_info('createAlignedTimeseries', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSCreateAlignedTimeseriesReq'}}}]}
;
function_info('createAlignedTimeseries', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('createAlignedTimeseries', exceptions) ->
  {struct, []}
;
% createMultiTimeseries(This, Req)
function_info('createMultiTimeseries', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSCreateMultiTimeseriesReq'}}}]}
;
function_info('createMultiTimeseries', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('createMultiTimeseries', exceptions) ->
  {struct, []}
;
% deleteTimeseries(This, SessionId, Path)
function_info('deleteTimeseries', params_type) ->
  {struct, [{1, i64},
          {2, {list, string}}]}
;
function_info('deleteTimeseries', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('deleteTimeseries', exceptions) ->
  {struct, []}
;
% deleteStorageGroups(This, SessionId, StorageGroup)
function_info('deleteStorageGroups', params_type) ->
  {struct, [{1, i64},
          {2, {list, string}}]}
;
function_info('deleteStorageGroups', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('deleteStorageGroups', exceptions) ->
  {struct, []}
;
% insertRecord(This, Req)
function_info('insertRecord', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSInsertRecordReq'}}}]}
;
function_info('insertRecord', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('insertRecord', exceptions) ->
  {struct, []}
;
% insertStringRecord(This, Req)
function_info('insertStringRecord', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSInsertStringRecordReq'}}}]}
;
function_info('insertStringRecord', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('insertStringRecord', exceptions) ->
  {struct, []}
;
% insertTablet(This, Req)
function_info('insertTablet', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSInsertTabletReq'}}}]}
;
function_info('insertTablet', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('insertTablet', exceptions) ->
  {struct, []}
;
% insertTablets(This, Req)
function_info('insertTablets', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSInsertTabletsReq'}}}]}
;
function_info('insertTablets', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('insertTablets', exceptions) ->
  {struct, []}
;
% insertRecords(This, Req)
function_info('insertRecords', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSInsertRecordsReq'}}}]}
;
function_info('insertRecords', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('insertRecords', exceptions) ->
  {struct, []}
;
% insertRecordsOfOneDevice(This, Req)
function_info('insertRecordsOfOneDevice', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSInsertRecordsOfOneDeviceReq'}}}]}
;
function_info('insertRecordsOfOneDevice', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('insertRecordsOfOneDevice', exceptions) ->
  {struct, []}
;
% insertStringRecordsOfOneDevice(This, Req)
function_info('insertStringRecordsOfOneDevice', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSInsertStringRecordsOfOneDeviceReq'}}}]}
;
function_info('insertStringRecordsOfOneDevice', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('insertStringRecordsOfOneDevice', exceptions) ->
  {struct, []}
;
% insertStringRecords(This, Req)
function_info('insertStringRecords', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSInsertStringRecordsReq'}}}]}
;
function_info('insertStringRecords', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('insertStringRecords', exceptions) ->
  {struct, []}
;
% testInsertTablet(This, Req)
function_info('testInsertTablet', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSInsertTabletReq'}}}]}
;
function_info('testInsertTablet', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('testInsertTablet', exceptions) ->
  {struct, []}
;
% testInsertTablets(This, Req)
function_info('testInsertTablets', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSInsertTabletsReq'}}}]}
;
function_info('testInsertTablets', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('testInsertTablets', exceptions) ->
  {struct, []}
;
% testInsertRecord(This, Req)
function_info('testInsertRecord', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSInsertRecordReq'}}}]}
;
function_info('testInsertRecord', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('testInsertRecord', exceptions) ->
  {struct, []}
;
% testInsertStringRecord(This, Req)
function_info('testInsertStringRecord', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSInsertStringRecordReq'}}}]}
;
function_info('testInsertStringRecord', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('testInsertStringRecord', exceptions) ->
  {struct, []}
;
% testInsertRecords(This, Req)
function_info('testInsertRecords', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSInsertRecordsReq'}}}]}
;
function_info('testInsertRecords', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('testInsertRecords', exceptions) ->
  {struct, []}
;
% testInsertRecordsOfOneDevice(This, Req)
function_info('testInsertRecordsOfOneDevice', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSInsertRecordsOfOneDeviceReq'}}}]}
;
function_info('testInsertRecordsOfOneDevice', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('testInsertRecordsOfOneDevice', exceptions) ->
  {struct, []}
;
% testInsertStringRecords(This, Req)
function_info('testInsertStringRecords', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSInsertStringRecordsReq'}}}]}
;
function_info('testInsertStringRecords', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('testInsertStringRecords', exceptions) ->
  {struct, []}
;
% deleteData(This, Req)
function_info('deleteData', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSDeleteDataReq'}}}]}
;
function_info('deleteData', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('deleteData', exceptions) ->
  {struct, []}
;
% executeRawDataQuery(This, Req)
function_info('executeRawDataQuery', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSRawDataQueryReq'}}}]}
;
function_info('executeRawDataQuery', reply_type) ->
  {struct, {'iotdb_client_types', 'tSExecuteStatementResp'}};
function_info('executeRawDataQuery', exceptions) ->
  {struct, []}
;
% executeLastDataQuery(This, Req)
function_info('executeLastDataQuery', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSLastDataQueryReq'}}}]}
;
function_info('executeLastDataQuery', reply_type) ->
  {struct, {'iotdb_client_types', 'tSExecuteStatementResp'}};
function_info('executeLastDataQuery', exceptions) ->
  {struct, []}
;
% executeAggregationQuery(This, Req)
function_info('executeAggregationQuery', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSAggregationQueryReq'}}}]}
;
function_info('executeAggregationQuery', reply_type) ->
  {struct, {'iotdb_client_types', 'tSExecuteStatementResp'}};
function_info('executeAggregationQuery', exceptions) ->
  {struct, []}
;
% requestStatementId(This, SessionId)
function_info('requestStatementId', params_type) ->
  {struct, [{1, i64}]}
;
function_info('requestStatementId', reply_type) ->
  i64;
function_info('requestStatementId', exceptions) ->
  {struct, []}
;
% createSchemaTemplate(This, Req)
function_info('createSchemaTemplate', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSCreateSchemaTemplateReq'}}}]}
;
function_info('createSchemaTemplate', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('createSchemaTemplate', exceptions) ->
  {struct, []}
;
% appendSchemaTemplate(This, Req)
function_info('appendSchemaTemplate', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSAppendSchemaTemplateReq'}}}]}
;
function_info('appendSchemaTemplate', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('appendSchemaTemplate', exceptions) ->
  {struct, []}
;
% pruneSchemaTemplate(This, Req)
function_info('pruneSchemaTemplate', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSPruneSchemaTemplateReq'}}}]}
;
function_info('pruneSchemaTemplate', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('pruneSchemaTemplate', exceptions) ->
  {struct, []}
;
% querySchemaTemplate(This, Req)
function_info('querySchemaTemplate', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSQueryTemplateReq'}}}]}
;
function_info('querySchemaTemplate', reply_type) ->
  {struct, {'iotdb_client_types', 'tSQueryTemplateResp'}};
function_info('querySchemaTemplate', exceptions) ->
  {struct, []}
;
% setSchemaTemplate(This, Req)
function_info('setSchemaTemplate', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSSetSchemaTemplateReq'}}}]}
;
function_info('setSchemaTemplate', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('setSchemaTemplate', exceptions) ->
  {struct, []}
;
% unsetSchemaTemplate(This, Req)
function_info('unsetSchemaTemplate', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSUnsetSchemaTemplateReq'}}}]}
;
function_info('unsetSchemaTemplate', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('unsetSchemaTemplate', exceptions) ->
  {struct, []}
;
% dropSchemaTemplate(This, Req)
function_info('dropSchemaTemplate', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSDropSchemaTemplateReq'}}}]}
;
function_info('dropSchemaTemplate', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('dropSchemaTemplate', exceptions) ->
  {struct, []}
;
% handshake(This, Info)
function_info('handshake', params_type) ->
  {struct, [{-1, {struct, {'iotdb_client_types', 'tSyncIdentityInfo'}}}]}
;
function_info('handshake', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('handshake', exceptions) ->
  {struct, []}
;
% sendPipeData(This, Buff)
function_info('sendPipeData', params_type) ->
  {struct, [{1, string}]}
;
function_info('sendPipeData', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('sendPipeData', exceptions) ->
  {struct, []}
;
% sendFile(This, MetaInfo, Buff)
function_info('sendFile', params_type) ->
  {struct, [{1, {struct, {'iotdb_client_types', 'tSyncTransportMetaInfo'}}},
          {2, string}]}
;
function_info('sendFile', reply_type) ->
  {struct, {'iotdb_common_types', 'tSStatus'}};
function_info('sendFile', exceptions) ->
  {struct, []}
;
% getBackupConfiguration(This)
function_info('getBackupConfiguration', params_type) ->
  {struct, []}
;
function_info('getBackupConfiguration', reply_type) ->
  {struct, {'iotdb_client_types', 'tSBackupConfigurationResp'}};
function_info('getBackupConfiguration', exceptions) ->
  {struct, []}
;
% fetchAllConnectionsInfo(This)
function_info('fetchAllConnectionsInfo', params_type) ->
  {struct, []}
;
function_info('fetchAllConnectionsInfo', reply_type) ->
  {struct, {'iotdb_client_types', 'tSConnectionInfoResp'}};
function_info('fetchAllConnectionsInfo', exceptions) ->
  {struct, []}
;
function_info(_Func, _Info) -> erlang:error(function_clause).

function_names() -> 
  ['executeQueryStatementV2', 'executeUpdateStatementV2', 'executeStatementV2', 'executeRawDataQueryV2', 'executeLastDataQueryV2', 'executeAggregationQueryV2', 'fetchResultsV2', 'openSession', 'closeSession', 'executeStatement', 'executeBatchStatement', 'executeQueryStatement', 'executeUpdateStatement', 'fetchResults', 'fetchMetadata', 'cancelOperation', 'closeOperation', 'getTimeZone', 'setTimeZone', 'getProperties', 'setStorageGroup', 'createTimeseries', 'createAlignedTimeseries', 'createMultiTimeseries', 'deleteTimeseries', 'deleteStorageGroups', 'insertRecord', 'insertStringRecord', 'insertTablet', 'insertTablets', 'insertRecords', 'insertRecordsOfOneDevice', 'insertStringRecordsOfOneDevice', 'insertStringRecords', 'testInsertTablet', 'testInsertTablets', 'testInsertRecord', 'testInsertStringRecord', 'testInsertRecords', 'testInsertRecordsOfOneDevice', 'testInsertStringRecords', 'deleteData', 'executeRawDataQuery', 'executeLastDataQuery', 'executeAggregationQuery', 'requestStatementId', 'createSchemaTemplate', 'appendSchemaTemplate', 'pruneSchemaTemplate', 'querySchemaTemplate', 'setSchemaTemplate', 'unsetSchemaTemplate', 'dropSchemaTemplate', 'handshake', 'sendPipeData', 'sendFile', 'getBackupConfiguration', 'fetchAllConnectionsInfo'].

