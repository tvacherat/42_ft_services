#!/bin/sh

sed -i 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf

# Launch telegraf
/usr/bin/telegraf &

# Setup MariaDB
# See https://mariadb.com/kb/en/mysql_install_db/
# datadir must be /var/lib/mysql
/usr/bin/mysql_install_db --datadir="/var/lib/mysql"

# Start MariaDB
/usr/bin/mysqld_safe --datadir="/var/lib/mysql" --user=root --init_file=/base.sql &
sleep 3

mysql wordpress -u root < wordpress.sql

tail -f /dev/null
