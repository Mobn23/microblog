# Kubernetes manifests (mobn)

Apply order: `01` → `07`.

## Secrets

`03-secrets.yaml` is **not committed** (see `kubernetes/.gitignore`) since it holds real credentials.
Before applying `06-microblog.yaml` or `05-mysql.yaml`, create it locally from the template:

```sh
cp 03-secrets.yaml.example 03-secrets.yaml
# then replace each <base64-encoded-value> with:
echo -n 'your-value-here' | base64
```

`DATABASE_URL` must match `MYSQL_PASSWORD`, in the form:

```
mysql+pymysql://microblog:<MYSQL_PASSWORD>@mysql/microblog
```

## Storage

`04-mysql-pv.yaml` / `04-mysql-pvc.yaml` use a static `hostPath`-backed PersistentVolume
(`storageClassName: manual`), not dynamic Azure provisioning — this subscription's Azure
Policy blocks both Azure File and Azure Disk creation from the AKS CSI drivers.
