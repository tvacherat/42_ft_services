#!/bin/sh

# Launch telegraf
/usr/bin/telegraf &

# Launch influx daemon & sleep 4 for database init
/usr/sbin/influxd & sleep 4

# Initialize influxDB database w/ database='metrics' & password='password'
influx -execute "CREATE DATABASE metrics"
influx -execute "CREATE USER metrics_admin WITH PASSWORD 'password'"
influx -execute "GRANT ALL ON metrics TO metrics_admin"
influx -execute "CREATE RETENTION POLICY auto_delete ON metrics DURATION 1d REPLICATION 1 DEFAULT"

tail -f /dev/null
