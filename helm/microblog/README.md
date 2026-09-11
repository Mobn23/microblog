# Microblog Helm Chart

Packages the Microblog deployment (MySQL with persistent storage, the Flask app,
TLS Ingress via cert-manager, and a Horizontal Pod Autoscaler) as a reusable,
configurable Helm chart — the templated equivalent of the plain manifests in
`kubernetes/mobn/`.

## Prerequisites

- An `ingress-nginx` controller and `cert-manager` installed on the cluster,
  with a `ClusterIssuer`/`Issuer` matching `ingress.clusterIssuer` in values.
- A Secret named per `secretName` (default `microblog-secrets`) with keys
  `MYSQL_PASSWORD`, `MYSQL_ROOT_PASSWORD`, `DATABASE_URL`, `SECRET_KEY` —
  **not managed by this chart**, create it separately:

  ```sh
  kubectl create secret generic microblog-secrets \
    --from-literal=MYSQL_PASSWORD=<value> \
    --from-literal=MYSQL_ROOT_PASSWORD=<value> \
    --from-literal=DATABASE_URL='mysql+pymysql://microblog:<MYSQL_PASSWORD>@mysql/microblog' \
    --from-literal=SECRET_KEY=<value>
  ```

## Install

```sh
helm install microblog ./helm/microblog
```

Override any value in `values.yaml`, e.g. to disable the Ingress (useful for
local/offline testing without touching DNS or requesting a real certificate):

```sh
helm install microblog ./helm/microblog --set ingress.enabled=false
```

## Notes

- `mysql.pvName` / `mysql.hostPath` back a `hostPath`-backed `PersistentVolume`
  (`storageClassName: manual`) rather than dynamic cloud provisioning — this
  subscription's Azure Policy blocks both Azure File and Azure Disk creation
  from the AKS CSI drivers (see `kubernetes/mobn/README.md`).
- Verified with a live install into an isolated namespace: MySQL reachable
  and queryable, Microblog reachable through its Service (`HTTP 302`,
  matching production behavior), then fully torn down.
