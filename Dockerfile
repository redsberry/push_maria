# --------------------------------------------
# Eberry redsBerry PUSH solution TEST DRIVE
#  - MariaDB based Database
# 2019.04.25
# --------------------------------------------
FROM mariadb:10.4.5

RUN apt-get update && apt-get -y upgrade

ENV MYSQL_ROOT_PASSWORD eberry
ENV MYSQL_DATABASE REDSPUSH
ENV MYSQL_USER redspush
ENV MYSQL_PASSWORD eberry

# 최초 db initial file(.sh, .sql, .sql.gz)을 /docker-entrypoint-initdb.d/ 복사하면 컨테이너 생성시 실행한다.
#COPY dbs.import /docker-entrypoint-initdb.d/
#COPY db_init.sh /docker-entrypoint-initdb.d/
COPY my.cnf /etc/mysql/my.cnf
#RUN chmod +x /docker-entrypoint-initdb.d/db_init.sh
COPY ./schema /docker-entrypoint-initdb.d/


#RUN /docker-entrypoint-initdb.d/db_init.sh
# docker run 시 mysql data file을 위치를 호스트의 디렉토리로 맵핑한다.
# -v /storage/mysql2/mysql-datadir:/var/lib/mysql
