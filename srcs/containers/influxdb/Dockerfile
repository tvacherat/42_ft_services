FROM alpine:latest

COPY init.sh telegraf.conf ./

# Update-upgrade-dependancies
RUN apk -U upgrade && \
	apk add --no-cache influxdb telegraf

# Setup telegraf
RUN	mkdir -p /etc/telegraf && \
	rm -f /etc/telegraf/telegraf.conf && \
	mv telegraf.conf /etc/telegraf/

EXPOSE 8086

CMD ./init.sh
