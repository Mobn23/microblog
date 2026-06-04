#!/bin/sh

export PROMETHEUS_MULTIPROC_DIR=${PROMETHEUS_MULTIPROC_DIR:-/tmp/prometheus-multiproc}
mkdir -p "$PROMETHEUS_MULTIPROC_DIR"
rm -f "$PROMETHEUS_MULTIPROC_DIR"/*

. .venv/bin/activate
while true; do
    flask db upgrade
    if [ "$?" = "0" ]; then
        break
    fi
    echo Upgrade command failed, retrying in 5 secs...
    sleep 5
done
exec gunicorn -b :5000 --access-logfile - --error-logfile - -c gunicorn_config.py microblog:app
