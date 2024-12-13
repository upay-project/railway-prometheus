FROM prom/prometheus

# copy the default Prometheus configuration file
COPY prometheus.yml /etc/prometheus/prometheus.yml

# expose the Prometheus server port
EXPOSE 9090

# set the entrypoint command
COPY run.sh /run.sh
RUN chmod +x /run.sh

# run the Prometheus server
ENTRYPOINT [ "sh", "/run.sh" ]
