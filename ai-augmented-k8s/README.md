AI-Augmented Kubernetes Platform Case Study
=========================================

Cloud Platform: AWS (Free Tier)

Milestone 1: Automated Kubernetes Cluster Setup using EC2 User Data

Summary
-------
This folder contains EC2 User Data scripts and a minimal Terraform configuration to provision two EC2 instances (control plane + worker) on AWS and bootstrap a Kubernetes cluster automatically.

Content
-------
- `control-plane-user-data.sh` — EC2 User Data for control plane (Ubuntu 22.04)
- `worker-user-data.sh` — EC2 User Data for worker node (Ubuntu 22.04)
- `terraform/` — Terraform configuration to provision networking and two EC2 instances

Usage (high level)
-------------------
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
--------------
- The provided User Data scripts are for demo/proof-of-concept and use simple apt installs. Review security and hardening before production use.
- The Terraform configuration in this folder creates public EC2 instances for demonstration; in production use private subnets and bastion hosts.

Next steps
----------
Milestone 2 will include Kubernetes deployments (WordPress), labels/selectors, and CI/CD integration.
