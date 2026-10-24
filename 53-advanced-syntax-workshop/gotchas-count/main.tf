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

data "aws_availability_zones" "available" {}

# Known during plan: a data source
resource "aws_cloudwatch_log_group" "per_az" {
  count = length(data.aws_availability_zones.available.names)
  name  = "logs-${data.aws_availability_zones.available.names[count.index]}"
}

