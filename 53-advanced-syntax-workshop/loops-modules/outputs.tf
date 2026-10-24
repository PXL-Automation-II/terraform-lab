output "all_arns" {
  value       = values(module.log_groups)[*].arn
  description = "The ARNs of all log groups"
}
