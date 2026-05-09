## Building a Streaming ELT Pipeline from MySQL to Kafka with Flink CDC

![Kafka](https://img.shields.io/badge/Apache%20Kafka-Distributed%20Streaming-black?logo=apache-kafka&logoColor=white)
![Flink](https://img.shields.io/badge/Apache%20Flink-Stream%20Processing-E6526F?logo=apacheflink&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-CDC%20Source-4479A1?logo=mysql&logoColor=white)
![FlinkCDC](https://img.shields.io/badge/Flink%20CDC-Real%20Time%20ELT-orange)
![Docker](https://img.shields.io/badge/Docker-Containerized%20Environment-2496ED?logo=docker&logoColor=white)

This project demonstrates how to build a **real-time streaming ELT pipeline** that captures MySQL binlog events and streams them into Apache Kafka using Flink CDC.

The pipeline continuously monitors database changes such as:

- Inserts
- Updates
- Deletes
- Schema changes

and streams them into Kafka topics in real time.

#### Architecture Diagram
<img width="1095" height="335" alt="flink-cdc" src="https://github.com/user-attachments/assets/ebe3cfe1-9f4f-4f04-9c9a-4b1dc46156ef" />
