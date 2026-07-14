terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }

  # Remote state — create this S3 bucket + DynamoDB table manually (or via a
  # separate one-time bootstrap) BEFORE running terraform init here.
  backend "s3" {
    bucket         = "bankops-terraform-state"      # change to a globally-unique bucket name
    key            = "prod/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "bankops-terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}