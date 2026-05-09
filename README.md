## Building a Streaming ELT Pipeline from MySQL to Kafka with Flink CDC

![workflow](https://github.com/zablon-oigo/flinkCDC-streaming-ELT-MySQL-Kafka/actions/workflows/ci.yml/badge.svg)
![Kafka](https://img.shields.io/badge/Apache%20Kafka-Distributed%20Streaming-black?logo=apache-kafka&logoColor=white)
![Flink](https://img.shields.io/badge/Apache%20Flink-Stream%20Processing-E6526F?logo=apacheflink&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-CDC%20Source-4479A1?logo=mysql&logoColor=white)
![FlinkCDC](https://img.shields.io/badge/Flink%20CDC-Real%20Time%20ELT-orange)
![Docker](https://img.shields.io/badge/Docker-Containerized%20Environment-2496ED?logo=docker&logoColor=white)
![Makefile](https://img.shields.io/badge/Makefile-Automation-blue?logo=gnu-make&logoColor=white)

This project demonstrates how to build a **real-time streaming ELT pipeline** that captures MySQL binlog events and streams them into Apache Kafka using Flink CDC.

The pipeline continuously monitors database changes such as:

- Inserts
- Updates
- Deletes
- Schema changes

and streams them into Kafka topics in real time.

#### Architecture Diagram
<img width="1095" height="335" alt="flink-cdc" src="https://github.com/user-attachments/assets/ebe3cfe1-9f4f-4f04-9c9a-4b1dc46156ef" />


### Quick Start

Follow these steps to run the pipeline locally:

> Tip: Run commands in order. Each step depends on the previous one being completed successfully.


```sh
# 1. First-time setup (build + start all services)
make setup

# 2. Check running containers
make ps

# 3. Log into MySQL and run SQL scripts
make mysql

# 4. Create Kafka topic
make create-topic

# 5. Run Flink CDC pipeline
make run-job

```


### SQL Setup 

**Create Database**

```sh
-- create database
CREATE DATABASE app_db;

USE app_db;
```

**Create and Populate the orders Table**

```sh
CREATE TABLE orders (
    id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO orders (id, price) VALUES (1, 4.00);
INSERT INTO orders (id, price) VALUES (2, 100.00);
```


**Create and Populate the shipments Table**

```sh
CREATE TABLE shipments (
    id INT NOT NULL,
    city VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO shipments (id, city) VALUES (1, 'beijing');
INSERT INTO shipments (id, city) VALUES (2, 'xian');
```

**Create and Populate the products Table**

```sh
CREATE TABLE products (
    id INT NOT NULL,
    product VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO products (id, product) VALUES (1, 'Beer');
INSERT INTO products (id, product) VALUES (2, 'Cap');
INSERT INTO products (id, product) VALUES (3, 'Peanut');
```

### Verify Streaming

Open Kafka UI (AKHQ):

```sh
http://localhost:8087
```
You should see real-time CDC events flowing into the topic.

### Medium Article Link

[Building a Streaming ELT Pipeline from MySQL to Kafka with Flink CDC](https://medium.com/@zablon-oigo/building-a-streaming-elt-pipeline-from-mysql-to-kafka-with-flink-cdc-cb1b791569b8)
