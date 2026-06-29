✨Set up the environment from scratch (prerequisites, configuration files, secrets).
**Prerequisites**
The following tools should be installed for this project to work :
	- Docker
	- Docker Compose
	- Git
	- Make 
	- OpenSSL
**Secrets**
You should create the secrets directory and create 4 files with the passwords in them these files should be :
	- mdb_psd.txt : The password for the mariaDb user used to connect to the database
	- mdb_root_psd.txt : password for the root account for MariaDb, used for crating databases and users
	- user_psd.txt : Password for a non admin user on wordpress
	- wp_admin_psd.txt : Password for the wordpress admin

✨Build and launch the project using the Makefile and Docker Compose.
**Using the Makefile**
- make : build and start the project 
- make down : Stop the containers
- make re : Restart the containers
- make clean : Stop the containers, remove them as well as the networks and the volumes
- make fclean : Do all that clean does and remove the directories

**Using docker compose**
- docker-compose up -d : Build and start containers 
- docker-compose down : Stop and remove containers
- docker-compose down -v : Stop and remove containers, volumes, netwoks.
- docker-compose restart <service name> : Restart a service
- docker-compose build --no-cache : Rebuild containers without cache ## Interet ??
- docker-compose logs -f <service name> : Follow logs for a specific service

✨Use relevant commands to manage the containers and volumes.
**Container management**
- docker ps : List running containers
- docker ps -a : List all containers
- docker start <container name> : Start a container
- docker stop <container name> : Stop a container
- docker rm <container name> : Remove a container
- docker exec -it <container name> bash : Access a container's shell ##interet ??

**Volume management**
- docker volume ls : List all volumes
- docker volume inspect <volume name> : Inspect a volume
- docker volume rm <volume name> : Remove a volume

**Network management**
- docker network ls : List all networks
- docker network inspect <network name> : Inspect a network

✨Identify where the project data is stored and how it persists.
**Data storage locations**
MariaDB : Docker volume with a path on the host, /homme/lle-tuto/data/mariadb, contains the files from the database, stored in var/lib/mysql in the container.

WordPress : Docker volume with a path on the host, /homme/lle-tuto/data/wordpress, contains the files from the website, themes, plugins, config.

Nginx : No specific volumes, its configuration is stored in the docker image

**Persistance**
We are using named volumes that are dealt with as Docker volume by Docker. The data is made persistant and can be accessed and modified directly on the host system.
