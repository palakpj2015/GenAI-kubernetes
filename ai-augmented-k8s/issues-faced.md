Common Issues Faced

- Worker not joining: check `kubeadm join` token expiration, network connectivity, and kubelet logs.
- PVC stuck in Pending: check `StorageClass`, available EBS capacity, and `volumeBindingMode`.
- WordPress CrashLoopBackOff: check DB credentials, readiness/liveness probes, and resource limits.
- DNS resolution failure: check `kube-dns`/`coredns` pods and CoreDNS config.
- OOMKilled: increase limits or reduce memory usage.
