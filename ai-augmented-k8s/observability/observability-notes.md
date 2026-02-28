Observability Notes

Prometheus (helm):
- `helm repo add prometheus-community https://prometheus-community.github.io/helm-charts`
- `helm repo update`
- `helm install prometheus prometheus-community/prometheus`

Grafana (helm):
- `helm repo add grafana https://grafana.github.io/helm-charts`
- `helm install grafana grafana/grafana`

Troubleshooting tips:
- `kubectl describe` for events
- `kubectl logs` for pod logs
- `kubectl top nodes` / `kubectl top pods` for resource usage
- `kubectl get events` for cluster events
