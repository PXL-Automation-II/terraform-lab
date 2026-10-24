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

resource "aws_cloudwatch_log_group" "imported" {
  name = "manual-log-group"
}

moved {
  from = aws_cloudwatch_log_group.manual
  to   = aws_cloudwatch_log_group.imported
}
