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
  type = string
}

variable "ollama_port" {
  type    = number
  default = 11434
}

variable "model_name" {
  description = "Ollama model to pull on boot"
  type        = string
  default     = "tinyllama"
}

variable "app_security_group_id" {
  description = "Security group ID of the App EC2 - only this SG may reach the Ollama port"
  type        = string
}

variable "ssh_allowed_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}