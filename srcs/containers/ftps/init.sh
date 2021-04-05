#!/bin/sh

# Launch telegraf
/usr/bin/telegraf &

# Launch ftps server w/ vsftpd.conf
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf 
