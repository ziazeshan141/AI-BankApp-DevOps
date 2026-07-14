output "instance_id" {
  value = aws_instance.ollama.id
}

output "private_ip" {
  value = aws_instance.ollama.private_ip
}

output "security_group_id" {
  value = aws_security_group.ollama.id
}