FROM alpine:latest

COPY init.sh vsftpd.conf telegraf.conf ./

# Update-upgrade-dependancies
RUN apk -U upgrade && \
        apk add --no-cache vsftpd openssl telegraf

# Create ftp user
RUN mkdir -p etc/ftps/ftp_admin && \
	adduser --home=/etc/ftps/ftp -D ftp_admin && \
	echo "ftp_admin:password" | chpasswd

# Setup vsftpd
RUN echo "ftp" >> /etc/vsftpd/user_list && \
	rm -f /etc/vsftp/vsftpd.conf && \
	mv vsftpd.conf /etc/vsftpd/

# Setup SSL
RUN mkdir -p /etc/vsftpd/ssl && \
        openssl req -newkey rsa:4096 -x509 -sha256 -days 365 \
        -nodes -out /etc/vsftpd/ssl/ftservices.crt \
        -keyout /etc/vsftpd/ssl/ftservices.key -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=tvachera/CN=ftservices"

# Setup telegraf
RUN	mkdir -p /etc/telegraf && \
	rm -f /etc/telegraf/telegraf.conf && \
	mv telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE 21 7000-7002

CMD ./init.sh
