# License Manager

![CI actions](https://github.com/abarrak/license-manager/actions/workflows/ci.yaml/badge.svg)

This is a simple application to manage and monitor the license activation and details with alerts.

## Features

1. Integration with confluence inventory page (Atlassian) through API scraping feature.
2. Simple CRUD screens for managing inventory.
3. Alerts on expired licenses
3. Support for Prometheous exporter `/metrics` endpoints.

<image src="https://raw.githubusercontent.com/abarrak/license-manager/main/screenshots/2.png" width="60%" />

## Deployment

Apply the resources in `./deploy` to create the application in kubernetes cluster.

## Architecture

The main idea behind the solution is to fetch periodically list of managed assets or licenses from web page and instrument them through prometheus and grafana for easy monitoring and notification. The picture below summerizes the architecture:

![architecture](https://raw.githubusercontent.com/abarrak/license-manager/main/screenshots/architecture.png)


## Prometheus & Grafana Integration

Apply the following secret including the scrape details, then restart:

```bash
$ kubectl create secret generic additional-scrape-configs --from-file=deploy/prometheus-additional.yaml -n monitoring
$ kubectl rollout restart deploy,sts -n monitoring
```

Also, the grafana dashboard file is available in `./prometheus` folder.

## License

MIT.
