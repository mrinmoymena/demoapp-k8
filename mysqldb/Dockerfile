FROM mysql:latest

MAINTAINER mrinmoy mena

ENV MYSQL_DATABASE="test" \
    MYSQL_ROOT_PASSWORD="password"

ADD schema.sql /docker-entrypoint-initdb.d

EXPOSE 3306
