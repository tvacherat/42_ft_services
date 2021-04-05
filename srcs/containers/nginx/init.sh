#!/bin/sh

# Launch telegraf
/usr/bin/telegraf &

#Launch Nginx
/usr/sbin/nginx

tail -f /dev/null
