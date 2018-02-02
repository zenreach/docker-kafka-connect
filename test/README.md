This test directory is used to ensure prometheus metrics compatibility for CI, and also for local testing with kafka connect. It is currently set up to test with mongo and the debezium source connector, and a corresponding sink connector that is compatible with the debezium CDC format. If you would like to test with other connectors, please refer to your connector's documentation for configuration and examples.

To run:

```
docker-compose up -d
```

This will launch:
- one zookeeper node
- one kafka node
- one avro schema registry instance
- one kafka connect worker
- a single member mongo replica set

Once everything is running, all services have host mappings, so you should be able to use standard cli client tools. The one exception here is kafka. Tools like `kafkacat` will still consult zookeeper for kafka brokers, so you'll have to add an entry in your hosts file that maps the "kafka" host to localhost.

First, you'll need to configure the replica set in mongo:
```
> mongo localhost:27017 --eval 'rs.initiate()'
```

Next, configure the mongo source and sink connectors on the kafka connect worker:
```
> curl -XPUT "http://localhost:8083/connectors/mongo-foo-bar-source/config" -H "Content-Type: application/json" -H "Accept: application/json" --data-binary @source-config.json
> curl -XPUT "http://localhost:8083/connectors/mongo-foo-bar-copy-sink/config" -H "Content-Type: application/json" -H "Accept: application/json" --data-binary @sink-config.json
```

Kafka topics will be auto-created, so to create one, insert some data into the "foo.bar" collection in mongo:
```
> mongo foo
> db.bar.insert({hello: "world!"})
```

While in the mongo shell, you should see the document copied to the `bar_copy` collection:
```
> db.bar_copy.find()
```

... and to see the kafka output:
```
> kafkacat -C -b localhost:9092 -t test.foo.bar -o 0
```
