# Del 2 Monitoring Guide

## What was implemented

- A dedicated monitoring VM runs Prometheus, Grafana, Alertmanager, and node-exporter.
- Prometheus scrapes the two Microblog app servers on `/metrics`.
- Grafana uses Prometheus as datasource through the `community.grafana.grafana_datasource` Ansible module.
- Grafana is exposed through the load balancer at `/grafana/`.
- Alertmanager forwards alerts to the configured `webhook.site` URL.
- A deliberate error route was added to the app: `/trigger-monitoring-error`.

## How the monitoring works

1. The Flask app exposes Prometheus metrics through `prometheus_flask_exporter`.
2. Prometheus scrapes both app servers and stores request metrics.
3. A Prometheus alert rule watches for HTTP 5xx responses:
   - `sum(increase(flask_http_request_total{job="flask",status=~"5.."}[1m])) > 0`
4. Alertmanager sends matching alerts to `webhook.site`.
5. Grafana shows the metrics in the `Microblog Errors` dashboard.

## Deploy order

Because the VM app deployment uses the Docker image `mobn23/microblog:1.0.0-prod`, the app code changes must be included in the image before the new route exists on the servers.

Recommended order:

1. Build and push the updated production image
2. Redeploy the app:
   - `ansible-playbook microblog_app.yml`
3. Apply monitoring changes:
   - `ansible-playbook monitoring_deploy.yml`
4. Apply the load balancer Grafana proxy:
   - `ansible-playbook deploy_lb_monitoring.yml`

## How to trigger the test error

Open this URL in a browser:

`https://mobn23.me/trigger-monitoring-error`

That route intentionally raises a `RuntimeError` and returns HTTP 500.

## How to verify it in Grafana

1. Open `https://mobn23.me/grafana/`
2. Log in with:
   - user: `admin`
   - password: `admin`
3. Open the dashboard `Microblog Errors`
4. Check:
   - `HTTP 5xx Responses Last 5m`
   - `Application Errors Per App Server`

After triggering the error, the 5xx metrics should increase within about one scrape interval.

## How to verify the alert

1. Trigger the error at `https://mobn23.me/trigger-monitoring-error`
2. Wait roughly 10-30 seconds
3. Open the configured `webhook.site` inbox
4. Confirm a request arrived from Alertmanager

## Relevant code locations

- Error trigger route:
  - `app/main/routes.py`
- 500 error logging:
  - `app/errors/handlers.py`
- Prometheus scrape config:
  - `ansible/roles/monitoring_stack/templates/prometheus.yml.j2`
- Prometheus alert rules:
  - `ansible/roles/monitoring_stack/templates/rules.yml.j2`
- Alertmanager webhook config:
  - `ansible/roles/monitoring_stack/templates/alertmanager.yml.j2`
- Grafana dashboard and datasource setup:
  - `ansible/roles/monitoring_stack/tasks/main.yml`
- Grafana reverse proxy:
  - `ansible/roles/deploy_lb/templates/load-balancer.conf.j2`
