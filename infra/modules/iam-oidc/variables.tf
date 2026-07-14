variable "project_name" {
  type = string
}

variable "role_name" {
  description = "Name of the IAM role GitHub Actions will assume"
  type        = string
  default     = "GitHubActionsRole"
}

variable "github_org" {
  description = "Your GitHub username or organization name"
  type        = string
}

variable "github_repo" {
  description = "Repository name (without org prefix)"
  type        = string
}

variable "allowed_branches" {
  description = "Branches allowed to assume this role"
  type        = list(string)
  default     = ["main"]
}

variable "secrets_manager_arn" {
  description = "ARN of the Secrets Manager secret this role may read"
  type        = string
}