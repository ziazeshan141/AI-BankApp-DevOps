output "ecr_repository_url" {
  value = module.ecr.repository_url
}

output "app_ec2_public_ip" {
  value = module.ec2_app.public_ip
}

output "app_ec2_instance_id" {
  value = module.ec2_app.instance_id
}

output "ollama_private_ip" {
  value = module.ec2_ollama.private_ip
}

output "github_actions_role_arn" {
  description = "Set this as the AWS_ROLE_ARN GitHub secret"
  value       = module.iam_oidc.role_arn
}

output "secrets_manager_secret_name" {
  value = module.secrets.secret_name
}