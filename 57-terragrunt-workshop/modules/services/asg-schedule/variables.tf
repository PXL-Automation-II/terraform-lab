variable "asg_name" {
  description = "The name of the Auto Scaling Group to scale"
  type        = string
}

variable "min_size" {
  description = "The number of EC2 instances outside business hours"
  type        = number
}

variable "max_size" {
  description = "The number of EC2 instances during business hours"
  type        = number
}
