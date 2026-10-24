terraform {
  required_version = ">= 1.12.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "log_groups" {
  source = "../modules/log-group"

  for_each = toset(var.names)
  name     = each.value
}
