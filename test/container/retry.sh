#!/usr/bin/env bash

CMD="$@"

$CMD
while [ "$?" != "0" ]; do
    sleep 1
    $CMD
done
