FROM confluentinc/cp-kafka-connect:3.2.2
ENV EXTRA_ARGS="-javaagent:/etc/kafka-connect/jars/jmx_prometheus_javaagent-0.10.jar=9242:/etc/jmx_exporter/jmx_exporter.yaml "
EXPOSE 9242
RUN mkdir -p /etc/jmx_exporter
ADD ./jmx_exporter.yaml /etc/jmx_exporter
ADD ./libs/*.jar /etc/kafka-connect/jars/
