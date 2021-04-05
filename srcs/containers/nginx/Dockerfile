FROM alpine:latest

COPY nginx.conf init.sh telegraf.conf ./

# Update-upgrade-dependancies
RUN apk -U upgrade && \
	apk add nginx openssl telegraf --no-cache

# Setup nginx
RUN mkdir -p /www /run/nginx && \
	mv nginx.conf /etc/nginx/
ADD index /www/

# Setup SSL
RUN mkdir -p /etc/nginx/ssl && \
	openssl req -newkey rsa:4096 -x509 -sha256 -days 365 \
	-nodes -out /etc/nginx/ssl/ftservices.crt \
	-keyout /etc/nginx/ssl/ftservices.key -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=tvachera/CN=ftservices"

# Setup Telegraf
RUN	mkdir -p /etc/telegraf && \
	rm -f /etc/telegraf/telegraf.conf && \
	mv telegraf.conf /etc/telegraf/

EXPOSE 80 443

ENTRYPOINT ./init.sh
