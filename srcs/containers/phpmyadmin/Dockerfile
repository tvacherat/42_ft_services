FROM alpine:latest

COPY init.sh nginx.conf config.inc.php telegraf.conf ./

# Update-upgrade-dependancies
RUN apk -U upgrade && \
        apk add --no-cache nginx php7 php7-fpm php7-opcache php7-gd php7-mysqli \
		php7-zlib php7-curl php7-mbstring php7-json php7-session telegraf

# Setup nginx
RUN mkdir -p /www /run/nginx && \
	mv nginx.conf /etc/nginx/

# Setup Phpmyadmin
ADD https://files.phpmyadmin.net/phpMyAdmin/4.9.2/phpMyAdmin-4.9.2-english.tar.gz .

RUN	tar -xf phpMyAdmin-4.9.2-english.tar.gz -C /www/ && \
	mv /www/phpMyAdmin-4.9.2-english /www/phpmyadmin && \
	mv /config.inc.php /www/phpmyadmin/ && \
	chown -R 755 /www/phpmyadmin

# Setup telegraf
RUN	mkdir -p /etc/telegraf && \
	rm -f /etc/telegraf/telegraf.conf && \
	mv telegraf.conf /etc/telegraf/

EXPOSE 5000

CMD ./init.sh
