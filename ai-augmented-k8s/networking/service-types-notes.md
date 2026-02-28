Service Types Notes

- ClusterIP: internal-only service within cluster. Use for internal components.
- NodePort: exposes a port on each node (demo-simple). Use small-range NodePort (30000-32767).
- LoadBalancer: cloud provider creates external LB (recommended for production).

Demo: Use `wordpress` NodePort to curl from cluster nodes or use `kubectl port-forward` for local testing.