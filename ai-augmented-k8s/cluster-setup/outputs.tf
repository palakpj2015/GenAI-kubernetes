output "control_public_ip" {
  value = aws_instance.control.public_ip
}

output "worker_public_ip" {
  value = aws_instance.worker.public_ip
}

output "control_private_ip" {
  value = aws_instance.control.private_ip
}

output "worker_private_ip" {
  value = aws_instance.worker.private_ip
}
