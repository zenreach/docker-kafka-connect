This test directory is used to ensure prometheus metrics compatibility for CI, and also for local testing with kafka connect. It is currently set up to test with mongo and the debezium source connector. If you would like to test with other connectors, please refer to your connector's documentation for configuration and examples.

To run:

```
docker-compose up
```

This will launch:
- one zookeeper node
- one kafka node
- one avro schema registry instance
- one kafka connect worker
- a "sharded" mongo cluster consisting of
    - a router (mongos)
    - a single replica set member
    - 3 config nodes

It will also spawn a couple of one-shot containers to run idempotent configuration of the mongo cluster and debezium connector.

Once everything is running, all services, except for the mongo replica and config nodes, have host mappings, so you should be able to use standard cli client tools. The one exception here is kafka. Tools like kafkacat will still consult zookeeper for kafka brokers, so you'll have to add an entry in your hosts file that maps the "kafka" host to localhost.

Kafka topics will be auto-created, so to create one, insert some data into the "test" db in mongo:
```
> mongo test
> db.foo.insert({bar: "hello, world!"})
```

Then, to see the kafka output:
```
> kafkacat -C -b localhost:9092 -t test.test.foo -o 0
```
