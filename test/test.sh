#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR
docker-compose up -d
curl "http://localhost:8083/connectors" &> /dev/null
while [ "$?" != "0" ]; do
    curl "http://localhost:8083/connectors" &> /dev/null
done
curl -XPUT "http://localhost:8083/connectors/platform-people-source/config" -H "Content-Type: application/json" -H "Accept: application/json" --data-binary @source-config.json || exit 1
curl -XPUT "http://localhost:8083/connectors/platform-people-sink/config" -H "Content-Type: application/json" -H "Accept: application/json" --data-binary @sink-config.json || exit 1
curl -s "http://localhost:9242/metrics" | promtool check metrics || exit 1
docker-compose down
