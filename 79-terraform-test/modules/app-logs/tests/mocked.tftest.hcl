# A fake AWS provider: the test needs no credentials and creates nothing
mock_provider "aws" {
  mock_resource "aws_cloudwatch_log_group" {
    defaults = {
      arn = "arn:aws:logs:us-east-1:111111111111:log-group:mocked"
    }
  }
}

run "apply_with_a_mocked_provider" {
  command = apply

  variables {
    environment = "staging"
  }

  assert {
    condition     = output.name == "staging-app-logs"
    error_message = "The output name is wrong."
  }

  assert {
    condition     = startswith(output.arn, "arn:aws:logs:")
    error_message = "The output arn must be a log group ARN."
  }
}
