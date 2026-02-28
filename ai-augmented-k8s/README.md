AI-Augmented Kubernetes Platform Case Study
=========================================

Cloud Platform: AWS (Free Tier)

Milestone 1: Automated Kubernetes Cluster Setup using EC2 User Data

Summary

Content

Usage (high level)
1. Review and edit variables in `terraform/variables.tf` (region, key_name).
2. Place your existing SSH key name (AWS Key Pair) in the `key_name` variable.
3. From `ai-augmented-k8s/terraform` run:

```bash
terraform init
terraform plan -out plan.tfplan
terraform apply plan.tfplan
```

4. After control plane finishes booting, SSH to the control plane instance and retrieve the join command saved at `/home/ubuntu/join-command.sh`. Paste that into the worker node (or edit the worker user-data before provisioning).

Notes & Safety

Next steps
Milestone 2 will include Kubernetes deployments (WordPress), labels/selectors, and CI/CD integration.

AI-Augmented Kubernetes Case Study

This repository is a compact demo for provisioning a small Kubernetes cluster (EC2 control + worker), deploying a WordPress (stateless) and MySQL (stateful) application, and showing basic networking, observability and GenAI integration notes.

Folder layout (clean, milestone-aligned):
- `cluster-setup/` — Terraform `main.tf`, `variables.tf`, `outputs.tf` and `control-plane-userdata.sh` + `worker-userdata.sh`.
- `kubernetes-basics/` — `namespace.yaml`, `sample-pod.yaml`, `basics-notes.md`.
- `application/` — WordPress and MySQL manifests, `storageclass.yaml`, PVC and Secret.
- `networking/` — connectivity test pod and `service-types-notes.md`.
- `observability/` — quick Prometheus/Grafana notes and troubleshooting tips.
- `genai/` — K8sGPT and embeddings notes plus a `sample-ai-script.py`.

Use the `cluster-setup` Terraform to provision instances, then apply the manifests in `kubernetes-basics/` and `application/` to run the demo. See individual folders for step-by-step notes.
