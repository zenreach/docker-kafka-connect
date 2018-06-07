#!/usr/bin/env bash

if [ "$ECS" == "true" ]
then
    host_port=`get-ecs-binding | sed -r 's/^([^:]+):(.*)$/\1 \2/g'`

    export CONNECT_REST_ADVERTISED_HOST=`echo $host_port | awk '{print $1}'`
    export CONNECT_REST_ADVERTISED_PORT=`echo $host_port | awk '{print $2}'`

    echo "host: $CONNECT_REST_ADVERTISED_HOST"
    echo "port: $CONNECT_REST_ADVERTISED_PORT"
fi

/etc/confluent/docker/run
