output "arn" {
  value       = aws_cloudwatch_log_group.example.arn
  description = "The ARN of the log group"
}
