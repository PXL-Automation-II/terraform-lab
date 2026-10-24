variable "environment" {
  description = "The environment name, such as staging or prod"
  type        = string
  default     = "staging"
}

variable "enable_debug_logs" {
  description = "If true, create a log group for debug logs"
  type        = bool
  default     = false
}

variable "give_full_access" {
  description = "If true, create the full access policy, else the read-only policy"
  type        = bool
  default     = false
}
