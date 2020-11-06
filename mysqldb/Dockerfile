FROM mysql

MAINTAINER mrinmoy mena

ENV MYSQL_DATABASE="test" 

COPY ./schema.sql /docker-entrypoint-initdb.d/
