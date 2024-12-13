#!/usr/bin/sh

# Create Prometheus data directory
mkdir -p /prometheus

# Create Prometheus configuration directory
mkdir -p /etc/prometheus

# Inject config from environment variables
if [ -n "$PROMETHEUS_CONFIG" ]; then
  rm -f /etc/prometheus/prometheus.yml
  echo "$PROMETHEUS_CONFIG" > /etc/prometheus/prometheus.yml
  chmod 777 /etc/prometheus/prometheus.yml
fi

# Set default port
if [ -z "$PORT" ]; then
  PORT=9090
fi

if [ -z "$PROMETHEUS_ARGS" ]; then
  PROMETHEUS_ARGS="--config.file=/etc/prometheus/prometheus.yml \
    --storage.tsdb.path=/prometheus \
    --web.console.libraries=/usr/share/prometheus/console_libraries \
    --web.console.templates=/usr/share/prometheus/consoles \
    --web.external-url=http://localhost:$PORT/ \
    --log.level=info"
fi

# Start Prometheus
/bin/prometheus $PROMETHEUS_ARGS $@
