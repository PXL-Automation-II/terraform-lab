# Plan-only tests with a fake AWS provider: no credentials needed, nothing created
mock_provider "aws" {}

variables {
  environment = "dev"
}

run "name_follows_the_environment" {
  command = plan

  assert {
    condition     = aws_cloudwatch_log_group.app.name == "dev-app-logs"
    error_message = "The name of the log group must start with the environment."
  }

  assert {
    condition     = aws_cloudwatch_log_group.app.retention_in_days == 7
    error_message = "Outside prod, the default retention must be 7 days."
  }
}

run "prod_keeps_logs_30_days" {
  command = plan

  variables {
    environment    = "prod"
    retention_days = 1
  }

  assert {
    condition     = aws_cloudwatch_log_group.app.retention_in_days == 30
    error_message = "Prod must keep its logs 30 days, whatever retention_days says."
  }
}

run "reject_unknown_environment" {
  command = plan

  variables {
    environment = "test"
  }

  expect_failures = [var.environment]
}

run "reject_unsupported_retention" {
  command = plan

  variables {
    retention_days = 10
  }

  expect_failures = [var.retention_days]
}
