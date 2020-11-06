FROM mysql:latest

MAINTAINER mrinmoy mena

ENV MYSQL_DATABASE="test" \
    MYSQL_ROOT_PASSWORD="P0ssword"

ADD schema.sql /docker-entrypoint-initdb.d

EXPOSE 3306
