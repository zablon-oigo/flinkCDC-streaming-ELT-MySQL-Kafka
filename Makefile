# Flink CDC MySQL - Kafka Pipeline Makefile

BOLD := \033[1m
GREEN := \033[32m
YELLOW := \033[33m
BLUE := \033[34m
CYAN := \033[36m
RED := \033[31m
RESET := \033[0m


.PHONY: help

help:
	@echo "$(BOLD)$(CYAN)Flink CDC MySQL -  Kafka Pipeline$(RESET)"
	@echo ""
	@echo "$(BOLD)Docker Services$(RESET)"
	@echo "  $(YELLOW)setup$(RESET)             - Start all services"
	@echo "  $(YELLOW)down$(RESET)           - Stop all services"
	@echo "  $(YELLOW)restart$(RESET)        - Restart services"
	@echo "  $(YELLOW)destroy$(RESET)        - Remove containers and volumes"
	@echo "  $(YELLOW)logs$(RESET)           - View logs"
	@echo ""
	@echo "$(BOLD)Shell Access$(RESET)"
	@echo "  $(YELLOW)mysql$(RESET)          - Login to MySQL"
	@echo "  $(YELLOW)jobmanager$(RESET)     - Open Flink JobManager shell"
	@echo "  $(YELLOW)kafka-topics$(RESET)   - List Kafka topics"
	@echo ""
	@echo "$(BOLD)Pipeline$(RESET)"
	@echo "  $(YELLOW)run-job$(RESET)        - Run Flink CDC pipeline"
	@echo ""
	@echo "  $(YELLOW)urls$(RESET)           - Show service URLs"
	@echo ""


.PHONY: setup

setup:
	@echo "$(CYAN)Building containers (first time only)...$(RESET)"
	docker compose build --no-cache
	@echo "$(GREEN)Build complete$(RESET)"

	@echo "$(CYAN)Starting services...$(RESET)"
	docker compose up -d
	@echo "$(GREEN)All services running$(RESET)"

.PHONY: down

down:
	@echo "$(YELLOW)Stopping services...$(RESET)"
	docker compose down

.PHONY: restart

restart: down setup

.PHONY: destroy

destroy:
	@echo "$(RED)Removing containers and volumes...$(RESET)"
	docker compose down -v --remove-orphans
	@echo "$(GREEN)Environment destroyed$(RESET)"

.PHONY: logs

logs:
	docker compose logs -f


.PHONY: ps

ps:
	@echo "$(CYAN)Listing running containers...$(RESET)"
	docker compose ps

.PHONY: mysql

mysql:
	docker compose exec db mysql -uroot -p123456


.PHONY: create-topic

create-topic:
	@echo "$(CYAN)Creating Kafka topic: yaml-mysql-kafka$(RESET)"
	docker compose exec kafka /opt/kafka/bin/kafka-topics.sh \
	--bootstrap-server localhost:9092 \
	--create \
	--topic yaml-mysql-kafka \
	--partitions 1 \
	--replication-factor 1 || true
	@echo "$(GREEN)Topic ready$(RESET)"


.PHONY: jobmanager

jobmanager:
	docker compose exec -it jobmanager bash

.PHONY: kafka-topics

kafka-topics:
	docker compose exec kafka /opt/kafka/bin/kafka-topics.sh \
	--bootstrap-server localhost:9092 --list


.PHONY: run-job

run-job:
	@echo "$(CYAN)Submitting Flink CDC pipeline...$(RESET)"
	docker compose exec -it jobmanager bash -c \
	"bash bin/flink-cdc.sh mysql-to-kafka.yaml"
	@echo "$(GREEN)Pipeline submitted$(RESET)"


.PHONY: urls

urls:
	@echo "$(BOLD)$(BLUE)Service URLs$(RESET)"
	@echo ""
	@echo "  Flink Dashboard    http://localhost:8082"
	@echo "  AKHQ Kafka UI      http://localhost:8087"
	@echo "  Kafka Broker       localhost:9092"
	@echo "  MySQL              localhost:3306"
	@echo ""
