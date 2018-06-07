#!/usr/bin/env bash

host_port=`echo "0.0.0.0:1234" | sed -r 's/^([^:]+):(.*)$/\1 \2/g'`

export CONNECT_REST_ADVERTISED_HOST=`echo $host_port | awk '{print $1}'`
export CONNECT_REST_ADVERTISED_PORT=`echo $host_port | awk '{print $2}'`

echo "host: $CONNECT_REST_ADVERTISED_HOST"
echo "host: $CONNECT_REST_ADVERTISED_PORT"
