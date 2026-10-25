output "name" {
  description = "The name of the log group"
  value       = aws_cloudwatch_log_group.app.name
}

output "arn" {
  description = "The ARN of the log group"
  value       = aws_cloudwatch_log_group.app.arn
}
