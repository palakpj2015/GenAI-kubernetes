AI-Augmented Kubernetes Case Study
=================================

Overview
--------
This case study implements the milestones you outlined: create a two-node Kubernetes cluster on AWS (Milestone 1), then deploy a stateless WordPress frontend and a stateful MySQL backend (Milestone 2+4). The repo contains Kubernetes manifests, CI/CD workflow skeletons, and notes for observability and GenAI integration.

Structure
---------
- `case-study/k8s/mysql/` — MySQL `Secret`, `PV/PVC`, `Service`, and `StatefulSet` manifests
- `case-study/k8s/wordpress/` — WordPress `Deployment` and `Service` manifests
- `.github/workflows/deploy.yml` — GitHub Actions skeleton for deploying manifests to a cluster

How to use
----------
1. Provision cluster (see `ai-augmented-k8s/terraform`) or use an existing cluster.
2. Configure kubeconfig locally or set `KUBE_CONFIG_DATA` secret in GitHub (base64 of kubeconfig).
3. Apply manifests locally for testing:

```bash
kubectl apply -f case-study/k8s/mysql/
kubectl apply -f case-study/k8s/wordpress/
```

Deliverables
------------
- Yaml files for stateless (WordPress) and stateful (MySQL) applications in `case-study/k8s`
- CI/CD workflow skeleton in `.github/workflows/deploy.yml`
- This README with next steps and assumptions

Next steps
----------
- Add Secrets and/or External DB credentials if required
- Add Helm charts and CI build steps
- Add observability stack (Prometheus/Grafana) and K8sGPT integration notes
