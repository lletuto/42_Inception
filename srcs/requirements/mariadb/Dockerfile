FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    mariadb-server \
    default-mysql-client \
    && rm -rf /var/lib/apt/lists/*

COPY ./conf.sh /conf.sh
RUN chmod +x /conf.sh

ENTRYPOINT ["/conf.sh"]

