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

# A conditional expression in an argument
resource "aws_cloudwatch_log_group" "app" {
  name              = "${var.environment}-app"
  retention_in_days = var.environment == "prod" ? 365 : 7
}

# If: count 1 or 0
resource "aws_cloudwatch_log_group" "debug" {
  count = var.enable_debug_logs ? 1 : 0

  name              = "${var.environment}-debug"
  retention_in_days = 1
}

# If-else: exactly one of the two policies exists
resource "aws_iam_policy" "cloudwatch_read_only" {
  count = var.give_full_access ? 0 : 1

  name   = "${var.environment}-cloudwatch-read-only"
  policy = data.aws_iam_policy_document.cloudwatch_read_only.json
}

resource "aws_iam_policy" "cloudwatch_full_access" {
  count = var.give_full_access ? 1 : 0

  name   = "${var.environment}-cloudwatch-full-access"
  policy = data.aws_iam_policy_document.cloudwatch_full_access.json
}

data "aws_iam_policy_document" "cloudwatch_read_only" {
  statement {
    effect    = "Allow"
    actions   = ["cloudwatch:Describe*", "cloudwatch:Get*", "cloudwatch:List*"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "cloudwatch_full_access" {
  statement {
    effect    = "Allow"
    actions   = ["cloudwatch:*"]
    resources = ["*"]
  }
}
