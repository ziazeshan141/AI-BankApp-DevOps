variable "secret_name" {
  type    = string
  default = "bankapp/prod-secrets"
}

variable "db_host" {
  type    = string
  default = "db"
}

variable "db_port" {
  type    = string
  default = "3306"
}

variable "db_name" {
  type    = string
  default = "bankappdb"
}

variable "db_user" {
  type      = string
  sensitive = true
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "ollama_url" {
  description = "Private URL of the Ollama AI tier, e.g. http://<private-ip>:11434"
  type        = string
}