variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "key_pair_name" {
  description = "Existing EC2 key pair name for SSH access"
  type        = string
}

variable "app_port" {
  type    = number
  default = 8080
}

variable "ssh_allowed_cidrs" {
  description = "CIDRs allowed to SSH in. Restrict this to your IP in production."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}