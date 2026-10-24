output "first_arn" {
  value       = aws_cloudwatch_log_group.example[0].arn
  description = "The ARN of the first log group"
}

output "all_arns" {
  value       = aws_cloudwatch_log_group.example[*].arn
  description = "The ARNs of all log groups"
}
