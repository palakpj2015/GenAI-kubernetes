variable "region" {
  type    = string
  default = "us-east-1"
}

variable "key_name" {
  type        = string
  description = "Existing AWS key pair name to use for SSH access"
  default     = "genai_k8s"
}


variable "my_ip_cidr" {
  type    = string
  default = "0.0.0.0/0"
  description = "CIDR allowed for SSH (set to your IP in production)"
}

variable "control_instance_type" {
  type    = string
  default = "t3.small"
}

variable "worker_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "root_volume_size" {
  type    = number
  default = 8
  description = "Root EBS volume size in GB for instances (smaller for cost savings)"
}
