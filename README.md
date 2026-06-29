*This project has been created as part of the 42 curriculum by lle-tuto*.

**Description**
Inception is a project to get acquainted with the concept of dockers and docker compose. In this project, I had to install three services using docker. I had to create a docker for each service and use docker compose to make them all work together. The three services are MariaDb, a database service, Nginx, a reverse proxy and WordPress a website builder. All three services had to work together to build a very simple website that has a admin user and safe connexion. 
To achieve this I had to write a dockerfile for each container and a configuration file. Then I used a docker-compose.yml file that would link them all up and deal with things such as secrets and volumes. 

**Instructions**
This project contains a makefile so you can use that. The rules are pretty basic, *make* builds the containers and starts them up, *clean* stops the containers, removes them as well as the networks and volumes. *fclean* the ultimate destroyerrr, will do the same thing as clean but it will also delete the data folders that were mandatory for this project. There is also a little *down* command that is just going to stop the containers and of course the good old *re* doing its work which is to clean and go back up ! Hope you are loving this because I am. Other things you could use are : *docker ps*, enables you to see which containers are up and for how long, therefore if they have crashed. Also why not use *docker log service_name* which will tell you the logs of a specific service and therefore possibly why it crashed, ain't this lovely. 

**Resources**
I used a lot of ressources for this project because I STRUGGLED but if you are an employer reading this, just keep in mind that I eventually succeeded (I hope so, kinda putting the charette before the boeufs here). 
I of course, used some of the official docker doc, especially about these bangers : 
https://docs.docker.com/get-started/docker-concepts/building-images/writing-a-dockerfile/ 
https://docs.docker.com/engine/swarm/secrets/ 
https://docs.docker.com/get-started/?source=post_page-----cfda98d9f4ac--------------------------------------- 
https://docker-curriculum.com/?source=post_page-----cfda98d9f4ac---------------------------------------#introduction

I read up on mariadb, nginx with these bad boys : 
https://www.mariadbtutorial.com/?source=post_page-----cfda98d9f4ac--------------------------------------- 
https://nginx.org/en/docs/
https://nginx.org/en/docs/http/configuring_https_servers.html

For wordpress I asked around a lot.
Also used this because I'm still figuring out git (again, futur employer, it's probably mastered by the time you're reading this) https://git-scm.com/docs/gitignore
As for AI, I used it as a friend and a therapist as it's meant to be used. I am kidding of course, I used AI to explain some concepts that I was struggling to understand, I asked it to make me some detailed lessons on the subjects of the project, bad for the environment I knowwwwwwwwwwwwwwwwwwww.🌍 I wrote this myself though, did you notice ?

**Project description**

**- Difference between a virtual machine and a docker :**
A virtual machine is an entire OS that's going to be installed in a separated part of the computer. A docker uses the machine's kernel but isolates the processes. To do that, the container uses two linux mechanisms : Namespaces that isolates processes, networks and the filing system and Cgroups which allows the limitations and control of ressources such as CPU and RAM. A docker container contains the librairies needed by the app, the code of this app and the configuration information.
A virtual machine is heavier and slower than a Docker container, A docker container is easier to move and easy to reproduce and modify.However the Docker is more vulnerable, if the kernel is compromised then so are the containers.

**- Docker secrets VS Environment variables :**
An environment is a pair key=value that's injected in a process and accessible by every program. The issue with environment variables is that they are visible and accessible for everyone that has access to a Docker daemon. The secrets can be copied and still accessible in the Dockerfile layers. Environment variables are useful but not the most secure, they can be used for other data.

Docker secrets are a mecanism specially made to store sensitive data such as passwords, API keys, TLS certificates, ...
The secret is stored on a file (ex : data/secrets/db_password) and saved in memory (tmpfs). It never appears in the environment variables or when *docker inspect* is done. Inside the container, the secret can be seen at the path like a normal file. It can be modified without having to reboot.

**- Docker Network vs Host Network :**
Docker containers are invisible to one anoter, Docker network allows the definition of the exact communications allowed between the containers.
The bridge network, the default docker network, is a virtual network, each container is connected to this network and has a private IP in the sub-network. Docker has a small DNS so there is no need to use the IPs.
The Docker Network(bridge network) allows isolation between the services and the rest, a communication between containers, each container has its own virtual network interface, we can control which container is communicating with wich with ports

With a host network the container does not have its own network interface, if the host is listening on port 80, itws the host port that is used. It is more efficient and useful for low level network monitoring. The lack of isolation is an inconvenient.

**- Docker Volumes vs Bind Mounts**
These are both solutions for the issue of persistance, when a container is deleted, all of its data is deleted as well, volumes and bind mounts allow to keep the data.

A bind mount is mapping a folder from the host in the container. The file that contains the data on the host is made visible in the container at a different path. A bind mount makes it easy to know where the data is on the host, it makes it easier to save, inspect and modify data. The inconvenients are its fragility, if the path to the file changes, it breaks, there can be issues with permissions. The path may not exist on a different machine which amke sit less portable, it's also less secure and can expose the host's files if it's incorrectly set up.

Docker volumes are a storing space entirely managed by Docker, the data is accessed by a logical name. They work with every host, every OS. They are entirely managed by docker, they can be inspected with *docker volume*. Docker volumes have better performances on Linux and can be shared easily between mulptiple containers.
However they are harder and less intuitive and less practical to use.
