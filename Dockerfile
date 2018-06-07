FROM confluentinc/cp-kafka-connect:4.0.0
LABEL maintainer="Zenreach Engineering <engineering@zenreach.com>"

ENV EXTRA_ARGS="-javaagent:/usr/local/share/jars/jmx_prometheus_javaagent-0.10.jar=9400:/etc/jmx_exporter/jmx_exporter.yaml "

ENV CONNECT_REST_PORT="80"
ENV CONNECT_PLUGIN_PATH="/usr/local/share/kafka_connect/plugins"
ENV CONNECT_KEY_CONVERTER="io.confluent.connect.avro.AvroConverter"
ENV CONNECT_VALUE_CONVERTER="io.confluent.connect.avro.AvroConverter"
ENV CONNECT_INTERNAL_KEY_CONVERTER="org.apache.kafka.connect.json.JsonConverter"
ENV CONNECT_INTERNAL_VALUE_CONVERTER="org.apache.kafka.connect.json.JsonConverter"

EXPOSE 9400
EXPOSE 80

RUN mkdir -p /etc/jmx_exporter

ADD ./jmx_exporter.yaml /etc/jmx_exporter
ADD ./libs/* /usr/local/share/jars/
ADD ./plugins /usr/local/share/kafka_connect/plugins/
ADD ./bin/* /usr/local/bin/

CMD ["/usr/local/bin/entrypoint.sh"]
