DOCKER_COMPOSE		= docker compose -f srcs/compose.yml
WP_DATA_DIR			= /home/cwenz/data/wordpress-volume
MBD_DATA_DIR		= /home/cwenz/data/mariadb-volume

all: up

create_volumes:
	@mkdir -p $(WP_DATA_DIR)
	@mkdir -p $(MBD_DATA_DIR)

delete_volumes:
	@cd /home/cwenz/data/ && rm  -rf  wordpress-volume
#	@rm -rf $(MBD_DATA_DIR)

build: create_volumes
	@echo "Building containers"
	$(DOCKER_COMPOSE) build

up: build
	@echo "Starting up containers"
	$(DOCKER_COMPOSE) up -d

clean:
	@echo "Removing docker containers..."
	$(DOCKER_COMPOSE) down

fclean: clean delete_volumes
	@echo "Removing all unused networks, and dangling images..."
	docker rmi $(shell docker images -q)
	docker volume rm $(shell docker volume ls -q)
	docker system prune -a

re: fclean all
	@echo "Rebuilding the project from scratch..."

.PHONY: all up down clean fclean re delete_volumes create_volumes
