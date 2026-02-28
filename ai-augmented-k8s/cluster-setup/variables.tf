variable "region" {
  type    = string
  default = "us-east-1"
}

variable "control_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "worker_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  type    = string
  default = "genai_k8s"
}

variable "my_ip_cidr" {
  type        = string
  description = "Your public IP in CIDR form (e.g. 1.2.3.4/32) used for SSH"
}

variable "root_volume_size" {
  type    = number
  default = 8
}
