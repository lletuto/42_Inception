FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    curl php php8.2-fpm php-mysql mariadb-client\
	&& rm -rf /var/lib/apt/lists/*

#copy to root
COPY ./conf.sh /

RUN chmod +x conf.sh

ENTRYPOINT [ "./conf.sh" ]
