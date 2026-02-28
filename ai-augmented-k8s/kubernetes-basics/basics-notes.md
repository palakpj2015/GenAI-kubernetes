Kubernetes Basics (genai-k8s namespace)

- Pod: smallest deployable unit. Run `kubectl get pods -n genai-k8s`.
- kube-apiserver: central API server that serves kube resources.
- etcd: key-value store for cluster state (control plane component).
- controller-manager: runs controllers to reconcile desired state.
- scheduler: assigns pods to nodes based on resources/constraints.
- Worker components: kubelet (agent), kube-proxy (service networking), container runtime (containerd).

Useful commands:
- `kubectl get pods -n genai-k8s`
- `kubectl describe pod <pod> -n genai-k8s`
- `kubectl logs <pod> -n genai-k8s`