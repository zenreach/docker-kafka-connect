#!/usr/bin/env bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR
docker-compose up -d
curl -XPUT "http://localhost:8083/connectors/psql-sink/config" -H "Content-Type: application/json" -H "Accept: application/json" --data-binary @sink-config.json
curl -s "http://localhost:9242/metrics" | promtool check-metrics
docker-compose down
