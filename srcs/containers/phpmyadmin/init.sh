#!/bin/sh

# Launch telegraf
/usr/bin/telegraf &

# Launch nginx
/usr/sbin/nginx

# Launch php
/usr/sbin/php-fpm7

tail -f /dev/null
