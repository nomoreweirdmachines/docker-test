FROM mysql:5.6.38

#this base image doesn't UTF8 support!! WTF?
#no this was me typing wrong!! LOL


MAINTAINER L33

COPY create-tables.sql /docker-entrypoint-initdb.d/mysqlcreate-tables.sql
WORKDIR /.
COPY  fortify1720settings.cnf /etc/mysql/conf.d/fortify1720settings.cnf 

#RUN echo "max_allowed_packet=1G" >> /etc/mysql/conf.d/docker.cnf

RUN chmod 777 /docker-entrypoint-initdb.d/mysqlcreate-tables.sql
