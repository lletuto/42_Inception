FROM debian:bookworm

#installs nginx and openssl --> tool kit  for SSL/TLS
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    nginx openssl && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

#Commands a self-signed certificates
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout \
	/etc/nginx/ssl/inception.key -subj "/C=FR/ST=Ile-de-France/L=PARIS/O=42/OU=42/CN=lle-tuto.42.fr/UID=lle-tuto"

COPY ./conf.conf /etc/nginx/nginx.conf
RUN chmod +x /etc/nginx/nginx.conf

RUN mkdir -p /var/www/html

RUN chown -R www-data:www-data /var/www/html

RUN mkdir -p /var/run/nginx

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
