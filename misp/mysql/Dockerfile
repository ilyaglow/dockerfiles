FROM mariadb:10.2
LABEL maintainer "Ilya Glotov <ilya@ilyaglotov.com>"

ADD --chown=mysql:mysql https://raw.githubusercontent.com/MISP/MISP/2.4/INSTALL/MYSQL.sql /docker-entrypoint-initdb.d/bootstrap.sql
