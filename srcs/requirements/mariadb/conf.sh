#!/bin/bash
set -e

ROOT_PWD=$(cat /run/secrets/mdb_root_psd)

mysqld_safe --datadir='/var/lib/mysql' &
echo "Waiting for MariaDB to start..."
while ! mysqladmin ping --silent; do
    sleep 1
done
echo "MariaDB temp started successfully."

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED VIA mysql_native_password USING PASSWORD('$ROOT_PWD');" 2>/dev/null || true
mysql -u root -p"$ROOT_PWD" -e "CREATE DATABASE IF NOT EXISTS \`$MDB_DATABASE\`;"
mysql -u root -p"$ROOT_PWD" -e "CREATE USER IF NOT EXISTS '$MDB_USER'@'%' IDENTIFIED BY '$(cat /run/secrets/mdb_psd)';"
mysql -u root -p"$ROOT_PWD" -e "GRANT ALL PRIVILEGES ON \`$MDB_DATABASE\`.* TO '$MDB_USER'@'%';"
mysql -u root -p"$ROOT_PWD" -e "DELETE FROM mysql.user WHERE User='';"
mysql -u root -p"$ROOT_PWD" -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p"$ROOT_PWD" shutdown
exec mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'