FROM alpine:latest

COPY init.sh dashboard.json dashboard.yaml datasource.yaml telegraf.conf ./

# Update-upgrade-dependancies
RUN apk -U upgrade && \
	apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ grafana && \
	mv datasource.yaml /usr/share/grafana/conf/provisioning/datasources/ && \
	mv dashboard.yaml /usr/share/grafana/conf/provisioning/dashboards/ && \
	mkdir -p /var/lib/grafana/dashboards && \
	mv dashboard.json /var/lib/grafana/dashboards/

# Setup telegraf
RUN	apk add --no-cache telegraf && \
	mkdir -p /etc/telegraf && \
	rm -f /etc/telegraf/telegraf.conf && \
	mv telegraf.conf /etc/telegraf/

EXPOSE 3000

CMD ./init.sh
