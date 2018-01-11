#!/usr/bin/env bash

until mongo mongo:27017 --eval 'rs.initiate({_id: "rs0", members: [{_id: 0, host: "mongo:27017"}]})'; do
  echo "retrying..."
  sleep 1
done

until mongo mongos:27017 --eval 'sh.addShard("rs0/mongo:27017")'; do
  echo "retrying..."
  sleep 1
done
