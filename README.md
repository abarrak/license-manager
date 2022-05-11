# License Manager

This is a simple application to manage and monitor the license activation and details with alerts.

## Features

1. Simple CRUD screens for managing inventory.
2. Alerts on expired licenses.
3. Support for Prometheous exporter `/metrics` endpoints.

## Deployment

Apply the resources in `./deploy` to create the application in kubernetes cluster.

## Prometheus & Grafana Integration

Apply the following secret including the scrape details, then restart:

```bash
$ kubectl create secret generic additional-scrape-configs --from-file=deploy/prometheus-additional.yaml -n sre-apps
$ kubectl rollout restart deploy,sts -n monitoring
```

Also, the grafana dashboard file is available in `./prometheus` folder.

## License

MIT.
