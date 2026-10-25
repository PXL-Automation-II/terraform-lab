terraform {
  required_version = ">= 1.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

resource "aws_cloudwatch_log_group" "app" {
  name              = "${var.environment}-app-logs"
  retention_in_days = var.environment == "prod" ? 30 : var.retention_days
}
