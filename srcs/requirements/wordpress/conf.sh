#!/bin/bash

set -e

if [ -z "$MDB_DATABASE" ] || [ -z "$MDB_USER" ] || [ -z "$(cat /run/secrets/mdb_psd)" ] || [ -z "$WP_ADMIN_N" ] || [ -z "$(cat /run/secrets/wp_admin_psd)" ] || [ -z "$WP_U_EMAIL" ]; then
	echo "Error : missing environment variable"
	exit 1
fi

cd /var/www/html
chmod -R 755 /var/www/html/
chown -R www-data /var/www/html


if [ ! -f wp-config.php ]; then
	echo " Installing Wordpress ..."
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp
	wp core download --allow-root
	wp core config --dbhost=mariadb:3306 --dbname="$MDB_DATABASE" --dbuser="$MDB_USER" --dbpass="$(cat /run/secrets/mdb_psd)" --allow-root
	wp core install --url="$DOMAIN_NAME:$PORT" --title="$WP_TITLE" --admin_user="$WP_ADMIN_N" --admin_email="$WP_ADMIN_E" --admin_password="$(cat /run/secrets/wp_admin_psd)" --allow-root
	wp user create "$WP_U_NAME" "$WP_U_EMAIL" --user_pass="$(cat /run/secrets/user_psd)" --role="$WP_U_ROLE" --allow-root
	echo "Wordpress installed ✅"
else
	echo "Wordpress already installed !🐇"
fi


if [ "$PORT" != "443" ]; then
	wp option update siteurl "https://$DOMAIN_NAME:$PORT" --allow-root
	wp option update home "https://$DOMAIN_NAME:$PORT" --allow-root
else
	wp option update siteurl "https://$DOMAIN_NAME" --allow-root
	wp option update home "https://$DOMAIN_NAME" --allow-root
fi

sed -i 's@/run/php/php8.2-fpm.sock@0.0.0.0:9000@' /etc/php/8.2/fpm/pool.d/www.conf

mkdir -p /run/php
exec php-fpm8.2 -F