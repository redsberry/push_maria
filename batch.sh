#!/bin/sh

docker stop `docker ps`
docker rm `docker ps -a`
docker rmi push_maria
docker rmi `docker images`
rm -rf mariadb

docker build -t push_maria:1.0 .

# docker run -d --name dbserver -v "$(pwd)/mariadb:/var/lib/mysql" \
# -e MYSQL_ROOT_PASSWORD=eberry \
# -e MYSQL_DATABASE=REDSPUSH \
# -e MYSQL_USER=redspush \
# -e MYSQL_PASSWORD=eberry \
# push_maria:1.0

docker run -d --name dbserver -v "$(pwd)/mariadb:/var/lib/mysql" push_maria:1.0

sleep 1

docker ps

# docker exec -it dbserver /bin/bash
