#!/bin/bash
set -eou pipefail
shopt -s nullglob

rm -rf gen-erl
thrift -r --gen erl:maps,legacynames,app_prefix=iotdb_ -I proto proto/common.thrift
thrift -r --gen erl:maps,legacynames,app_prefix=iotdb_ -I proto proto/client.thrift
cp gen-erl/*.hrl include/
cp gen-erl/*.erl src/proto/
rm -rf gen-erl
