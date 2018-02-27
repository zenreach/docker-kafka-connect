[![Build Status](https://travis-ci.org/zenreach/docker-kafka-connect.svg?branch=master)](https://travis-ci.org/zenreach/docker-kafka-connect)

# Kafka Connect Docker Container

This repo contains a Kafka Connect Docker container with the prometheus jmx exporter installed.

The docker image provided by this repo builds minimally on top of confluentinc/cp-kafka-connect. The only differences are that we install the prometheus jmx exporter and some third-party connector plugins.

We've found running the jmx exporter in server mode to be problematic, and prometheus recommends running the exporter as a java agent.

The third party plugins included are:

- [Debezium Source Connector for MongoDB](http://debezium.io/docs/connectors/mongodb/)
- [Debezium MongoDB CDC-Compatible Sink Connector](https://github.com/hpgrahsl/kafka-connect-mongodb)

## JMX

JMX options can be customized using the `KAFKA_JMX_OPTS` environment variable. The default value set by confluent is:

```
KAFKA_JMX_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false  -Dcom.sun.management.jmxremote.ssl=false "
```

## Prometheus Monitoring

Prometheus metrics will be exported on port 9400. The jmx metrics that are exported are those that match the patterns in the `jmx_exporter.yaml` config.

## Example

For example usage with the bundled third-party connectors, see the [test documentation](test/README.md).
