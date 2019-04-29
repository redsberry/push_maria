#!/bin/bash
echo "DB user create"
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}"
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* to ${MYSQL_USER}@'%' identified by '${MYSQL_PASSWORD}'"

sleep 1

echo "DB import"
mysql -u root -p$MYSQL_ROOT_PASSWORD < /docker-entrypoint-initdb.d/dbs.import
