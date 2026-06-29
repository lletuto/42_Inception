✨The services provided by the stack are : 
- **Nginx** : web server, reverse proxy 
- **Wordpress** : to create and manage a website
- **MariaDB** : Database for WP data
- **Docker** : Containering tool to isolate and manage services

✨Start and stop the project.
**Start the stack** : docker-compose up -d
**Stop the stack** : docker-compose down
**Stop the stack and delete volumes, networks and containers** : docker-compose down -v
**Restart one service** : docker-compose restart <service name>

✨Access the website and the administration panel.
**Access the website** : To access the website type out https://lle-tuto.42.fr
The certificate being self signed you may have to accept the security warning.
**Access the administration panel** : https://lle-tuto.42.fr/wp-admin
And use the variable $WP_ADMIN_N from the .env and the password from the file wp_admin_psd.txt in the secrets file

✨Locate and manage credentials.
The passwords have to be added from a folder called secrets and then they will be dealt with by Docker secrets
The other credentials can be found in the .env file

✨Check that the services are running correctly.
Check that all services are up : docker ps
Check the logs for one service : docker-compose logs <service name>
Test Nginx connectivity : curl -I https://lle-tuto.42.fr
Test MariaDB connectivity : docker-compose exec mariadb mysql -u$MDP_USER -e 



