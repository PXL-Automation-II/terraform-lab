# A real log group in AWS: Terraform creates it, checks it, and destroys it
provider "aws" {
  region = "us-east-1"
}

run "create_a_real_log_group" {
  command = apply

  variables {
    environment = "dev"
  }

  assert {
    condition     = startswith(aws_cloudwatch_log_group.app.arn, "arn:aws:logs:us-east-1:")
    error_message = "AWS did not return a log group ARN in us-east-1."
  }
}
