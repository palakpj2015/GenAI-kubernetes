Terraform notes
---------------

Place your AWS credentials in the environment (AWS_ACCESS_KEY_ID/AWS_SECRET_ACCESS_KEY) or configure a profile.

Usage:

```bash
cd ai-augmented-k8s/terraform
terraform init
terraform apply -var='key_name=your-aws-keypair' -auto-approve
```

After apply completes, use the `control_public_ip` output to SSH into the control plane and get the join command:

```bash
ssh -i ~/.ssh/your-key.pem ubuntu@$(terraform output -raw control_public_ip)
cat /home/ubuntu/join-command.sh
```

Then either manually run the join command on the worker node (SSH) or place the full join command into `../worker-user-data.sh` before provisioning.
