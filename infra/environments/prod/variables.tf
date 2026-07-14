variable "project_name" {
  description = "Prefix used to name/tag all resources"
  type        = string
  default     = "bankops"
}

variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "availability_zone" {
  type    = string
  default = "us-east-2a"
}

variable "key_pair_name" {
  description = "Existing EC2 key pair name (create manually in AWS console first)"
  type        = string
}

variable "github_org" {
  description = "Your GitHub username or org name"
  type        = string
}

variable "github_repo" {
  description = "Repository name, e.g. bankops-platform"
  type        = string
}

variable "allowed_branches" {
  type    = list(string)
  default = ["main"]
}

variable "db_user" {
  type      = string
  sensitive = true
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "ssh_allowed_cidrs" {
  description = "Restrict SSH to your own IP in production, e.g. [\"203.0.113.5/32\"]"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}