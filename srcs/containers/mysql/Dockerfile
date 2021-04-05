FROM alpine:latest

COPY init.sh wordpress.sql base.sql my.cnf telegraf.conf ./

# Update-upgrade-dependancies
RUN apk -U upgrade && \
	apk add --no-cache mysql mysql-client telegraf

# Setup MariaDB
RUN mv my.cnf /etc/my.cnf && \
	mkdir -p /run/mysqld

# Setup telegraf
RUN	mkdir -p /etc/telegraf && \
	rm -f /etc/telegraf/telegraf.conf && \
	mv telegraf.conf /etc/telegraf/

EXPOSE 3306

CMD ./init.sh
