#!/bin/sh

# Launch telegraf
/usr/bin/telegraf &

# Launch Nginx
/usr/sbin/nginx

# Launch php
/usr/sbin/php-fpm7

tail -f /dev/null
