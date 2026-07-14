resource "aws_secretsmanager_secret" "app" {
  name        = var.secret_name
  description = "Production secrets for BankApp (DB credentials, AI tier URL)"

  tags = {
    Name = var.secret_name
  }
}

resource "aws_secretsmanager_secret_version" "app" {
  secret_id = aws_secretsmanager_secret.app.id

  # NOTE: values are passed in as sensitive variables from environments/prod/terraform.tfvars
  # (which is gitignored) — never hardcode real values here.
  secret_string = jsonencode({
    DB_HOST     = var.db_host
    DB_PORT     = var.db_port
    DB_NAME     = var.db_name
    DB_USER     = var.db_user
    DB_PASSWORD = var.db_password
    OLLAMA_URL  = var.ollama_url
  })

  lifecycle {
    ignore_changes = [secret_string] # allow manual rotation without drift on every plan
  }
}