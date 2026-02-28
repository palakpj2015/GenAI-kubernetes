terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_security_group" "k8s_sg" {
  name        = "ai-augmented-k8s-sg"
  description = "Security group for demo k8s cluster"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "control" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.control_instance_type
  key_name               = var.key_name
  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp2"
  }
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  user_data              = file("${path.module}/../control-plane-user-data.sh")
  tags = {
    Name = "k8s-control"
  }
}

resource "aws_instance" "worker" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.worker_instance_type
  key_name               = var.key_name
  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp2"
  }
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  user_data              = file("${path.module}/../worker-user-data.sh")
  tags = {
    Name = "k8s-worker"
  }
}
