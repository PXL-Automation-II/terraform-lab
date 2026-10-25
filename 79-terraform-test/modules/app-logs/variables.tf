variable "environment" {
  description = "The environment: dev, staging or prod"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "The environment must be dev, staging or prod."
  }
}

variable "retention_days" {
  description = "How many days the logs are kept, outside prod"
  type        = number
  default     = 7

  validation {
    condition     = contains([1, 3, 5, 7, 14, 30], var.retention_days)
    error_message = "CloudWatch accepts 1, 3, 5, 7, 14 or 30 days here."
  }
}
