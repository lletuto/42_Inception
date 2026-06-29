MAKE = make
DOCKER_COMPOSE = docker compose
DOCKER_COMPOSE_FILE = docker-compose.yml

up:
	@if [ ! -d "./secrets" ]; then \
		echo "Lena... you forgot the secrets file again"; \
		exit 1; \
	fi
	@mkdir -p /home/lle-tuto/data/wordpress
	@mkdir -p /home/lle-tuto/data/mariadb
	@cd ./srcs && docker compose up -d --build
	@echo "Containers have started 🐴"

down: # Stop the containers
	@cd ./srcs && docker compose down

#Pas supprimer les volumes, les supprimer dans le fclean !! IMPORTANT
clean: # Stop and remove all containers, networks, and volumes
	@cd ./srcs && docker compose down 
	@docker rmi $(shell docker images -q) --force || true
	@echo "Containers and images TO THE TRASHHHHH 🚽"

fclean: # Delete the directories
	@cd ./srcs && docker compose down --volumes --remove-orphans
	@docker rmi $(shell docker images -q) --force || true
	@sudo -v
	@sudo rm -rf /home/lle-tuto/data/wordpress
	@sudo rm -rf /home/lle-tuto/data/mariadb
	@sudo rm -rf /home/lle-tuto/data

	@echo "Removed data directories 🦅"

re: # Restart the containers
	@$(MAKE) clean && $(MAKE) up
	@echo "Omg containers are ready to start again 🦃"

.PHONY: up down re clean fclean