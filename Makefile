DOCKER_COMPOSE     = docker compose -f srcs/compose.yml
WP_DATA_DIR        = /home/cwenz/data/wordpress-volume
MBD_DATA_DIR       = /home/cwenz/data/mariadb-volume

all: up

create_volumes:
	@mkdir -p $(WP_DATA_DIR)
	@mkdir -p $(MBD_DATA_DIR)

delete_volumes:
	@rm -rf $(WP_DATA_DIR)
	@rm -rf $(MBD_DATA_DIR)

down:
	$(DOCKER_COMPOSE) down

start:
	$(DOCKER_COMPOSE) start

build: create_volumes
	@echo "Building containers"
	$(DOCKER_COMPOSE) build

up: build
	@echo "Starting up containers"
	$(DOCKER_COMPOSE) up -d

clean: down
	@echo "Removing docker containers, networks, and images created by up..."
	docker container prune -f
	docker network prune -f
	docker image prune -f

fclean: clean
	@echo "Removing all unused networks, and dangling images..."
	docker system prune -a -f

re: fclean all
	@echo "Rebuilding the project from scratch..."

.PHONY: all up down clean fclean re delete_volumes create_volumes start
