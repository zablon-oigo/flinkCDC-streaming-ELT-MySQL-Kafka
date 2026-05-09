FROM flink:2.2-java17

USER root

# Create directories
RUN mkdir -p /opt/flink/lib \
    && mkdir -p /opt/flink-cdc \
    && chown -R flink:flink /opt/flink-cdc

ENV FLINK_CDC_HOME=/opt/flink-cdc

# Copy YAML File
COPY --chown=flink:flink mysql-to-kafka.yaml /opt/flink-cdc/

# Download necessary CDC connectors and runtime modules
RUN wget -q --no-check-certificate -O /opt/flink/lib/flink-sql-connector-mysql-cdc-3.6.0-2.2.jar \
    https://repo1.maven.org/maven2/org/apache/flink/flink-sql-connector-mysql-cdc/3.6.0-2.2/flink-sql-connector-mysql-cdc-3.6.0-2.2.jar || echo "SQL connector download skipped" && \
    wget -q --no-check-certificate -O /opt/flink/lib/flink-sql-connector-kafka-2.2.0.jar \
    https://repo1.maven.org/maven2/org/apache/flink/flink-sql-connector-kafka/2.2.0/flink-sql-connector-kafka-2.2.0.jar || echo "Kafka SQL connector download skipped" && \
    wget -q --no-check-certificate -O /opt/flink/lib/flink-cdc-pipeline-connector-mysql-3.6.0-2.2.jar \
    https://repo1.maven.org/maven2/org/apache/flink/flink-cdc-pipeline-connector-mysql/3.6.0-2.2/flink-cdc-pipeline-connector-mysql-3.6.0-2.2.jar && \
    wget -q --no-check-certificate -O /opt/flink/lib/flink-cdc-pipeline-connector-kafka-3.6.0-2.2.jar \
    https://repo1.maven.org/maven2/org/apache/flink/flink-cdc-pipeline-connector-kafka/3.6.0-2.2/flink-cdc-pipeline-connector-kafka-3.6.0-2.2.jar && \
    wget -q --no-check-certificate -O /opt/flink/lib/flink-cdc-cli-3.6.0-2.2.jar \
    https://repo1.maven.org/maven2/org/apache/flink/flink-cdc-cli/3.6.0-2.2/flink-cdc-cli-3.6.0-2.2.jar && \
    wget -q --no-check-certificate -O /opt/flink/lib/snakeyaml-engine-2.7.jar \
    https://repo1.maven.org/maven2/org/snakeyaml/snakeyaml-engine/2.7/snakeyaml-engine-2.7.jar && \
    wget -q --no-check-certificate -O /opt/flink/lib/mysql-connector-j-8.3.0.jar \
    https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.3.0/mysql-connector-j-8.3.0.jar && \
    # Download the CDC runtime module
    wget -q --no-check-certificate -O /opt/flink/lib/flink-cdc-runtime-3.6.0-2.2.jar \
    https://repo1.maven.org/maven2/org/apache/flink/flink-cdc-runtime/3.6.0-2.2/flink-cdc-runtime-3.6.0-2.2.jar

# Download and extract the CDC distribution
RUN wget -q --no-check-certificate -O /tmp/flink-cdc-3.6.0-2.2-bin.tar.gz \
    https://dlcdn.apache.org/flink/flink-cdc-3.6.0/flink-cdc-3.6.0-2.2-bin.tar.gz && \
    tar -xzf /tmp/flink-cdc-3.6.0-2.2-bin.tar.gz -C /opt/flink-cdc --strip-components=1 && \
    rm /tmp/flink-cdc-3.6.0-2.2-bin.tar.gz && \
    chmod +x /opt/flink-cdc/bin/flink-cdc.sh && \
    chown -R flink:flink /opt/flink-cdc

USER flink

WORKDIR /opt/flink-cdc

CMD ["bash"]