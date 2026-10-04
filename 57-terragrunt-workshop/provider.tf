terraform {
  required_version = ">= 1.11.0" # use_lockfile needs Terraform 1.11+

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
