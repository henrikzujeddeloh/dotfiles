#!/usr/bin/env bash
#
# delete entire measurement from InfluxDB

org="personal"
bucket="bucket"

curl -v --request POST "$INFLUXDB_URL/api/v2/delete?org=$org&bucket=$bucket" \
  --header "Authorization: Token $INFLUXDB_API" \
  --header "Content-Type: application/json" \
  --data '{
    "start": "1970-01-01T00:00:00Z",
    "stop": "'"$(date -u +"%Y-%m-%dT%H:%M:%SZ")"'",
    "predicate": "_measurement=\"'"$1"'\""
  }'
