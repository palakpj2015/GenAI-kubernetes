provider "aws" {
  region = var.region
}

# VPC (simple single subnet) - optional but recommended for demo
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = { Name = "ai-augmented-vpc" }
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
}

data "aws_availability_zones" "available" {}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# Security group allowing SSH from your CIDR and kube ports
resource "aws_security_group" "k8s_sg" {
  name   = "k8s-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  ingress {
    description = "kube-apiserver"
    from_port   = 6443
    to_port     = 6443
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

# EC2 instances: control and worker
resource "aws_instance" "control" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.control_instance_type
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  key_name               = var.key_name
  user_data              = file("${path.module}/control-plane-userdata.sh")
  root_block_device {
    volume_size = var.root_volume_size
  }
  tags = { Name = "k8s-control" }
}

resource "aws_instance" "worker" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.worker_instance_type
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  key_name               = var.key_name
  user_data              = file("${path.module}/worker-userdata.sh")
  root_block_device {
    volume_size = var.root_volume_size
  }
  tags = { Name = "k8s-worker" }
}
