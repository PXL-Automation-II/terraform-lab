output "app_retention_in_days" {
  value = aws_cloudwatch_log_group.app.retention_in_days
}

output "policy_arn" {
  value = one(concat(
    aws_iam_policy.cloudwatch_full_access[*].arn,
    aws_iam_policy.cloudwatch_read_only[*].arn
  ))
}
