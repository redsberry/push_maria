#!/bin/bash
echo "DB Init."
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}"
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* to ${MYSQL_USER}@'%' identified by '${MYSQL_PASSWORD}'"

#echo "DB import"
#mysql -u root -p$MYSQL_ROOT_PASSWORD < dbs.import
