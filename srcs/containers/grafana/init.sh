#!/bin/sh

# Launch telegraf
/usr/bin/telegraf &

# Launch grafana's server
/usr/sbin/grafana-server --homepath=/usr/share/grafana
