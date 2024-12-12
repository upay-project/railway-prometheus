#!/usr/bin/sh

# Create Prometheus data directory
mkdir -p /prometheus

# Create Prometheus configuration directory
mkdir -p /etc/prometheus

# Inject config from environment variables
if [ -n "$PROMETHEUS_CONFIG" ]; then
  echo "$PROMETHEUS_CONFIG" > /etc/prometheus/prometheus.yml
fi

# Set default port
if [ -z "$PROMETHEUS_PORT" ]; then
  PROMETHEUS_PORT=9090
fi

if [ -z "$PROMETHEUS_ARGS" ]; then
  PROMETHEUS_ARGS="--config.file=/etc/prometheus/prometheus.yml \
    --storage.tsdb.path=/prometheus \
    --web.console.libraries=/usr/share/prometheus/console_libraries \
    --web.console.templates=/usr/share/prometheus/consoles \
    --web.external-url=http://localhost:$PROMETHEUS_PORT/ \
    --log.level=info"
fi

# Start Prometheus
/bin/prometheus $PROMETHEUS_ARGS $@