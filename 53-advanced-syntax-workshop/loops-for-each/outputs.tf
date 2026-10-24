output "all_log_groups" {
  value = aws_cloudwatch_log_group.example
}

output "all_arns" {
  value = values(aws_cloudwatch_log_group.example)[*].arn
}
