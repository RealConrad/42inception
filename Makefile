DOCKER_COMPOSE		= docker-compose -f srcs/compose.yml

all: up

build:
	@echo "Building containers"
	$(DOCKER_COMPOSE) build

up: build
	@echo "Starting up containers"
	$(DOCKER_COMPOSE) up

clean:
	@echo "Removing docker containers..."
	$(DOCKER_COMPOSE) down

fclean: clean
	@echo "Removing all unused networks, and dangling images..."
	docker rmi $(shell docker images -q)
	docker volume rm $(shell docker volume ls -q)
	docker system prune -a

re: fclean all
	@echo "Rebuilding the project from scratch..."

.PHONY: all up down clean fclean re