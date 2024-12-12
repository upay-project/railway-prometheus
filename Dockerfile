ARG VERSION="latest"
FROM prom/prometheus:${VERSION}

# copy the default Prometheus configuration file
COPY prometheus.yml /etc/prometheus/prometheus.yml

# expose the Prometheus server port
EXPOSE 9090

# set the entrypoint command
COPY run.sh /run.sh

# run the Prometheus server
USER root
ENTRYPOINT [ "/run.sh" ]
