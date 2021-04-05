FROM alpine:latest

COPY wp-config.php init.sh nginx.conf telegraf.conf ./

# Update-upgrade-dependancies
RUN apk -U upgrade && \
	apk add --no-cache php7 php7-fpm php7-opcache php7-gd php7-mysqli \
	php7-zlib php7-curl php7-mbstring php7-json php7-session nginx telegraf

# Setup nginx
RUN mkdir -p /www /run/nginx && \
	mv nginx.conf /etc/nginx/

# Setup Wordpress
ADD https://wordpress.org/latest.tar.gz .

RUN	tar -xzvf latest.tar.gz && \
	mv wordpress /www && \
	mv wp-config.php /www/wordpress && \
	chown -R root:www-data /www && \
	chmod -R 755 /www && \
	rm -f latest.tar.gz 

# Setup telegraf
RUN	mkdir -p /etc/telegraf && \
	rm -f /etc/telegraf/telegraf.conf && \
	mv telegraf.conf /etc/telegraf/

EXPOSE 5050

CMD ./init.sh
