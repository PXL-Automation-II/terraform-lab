variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

variable "cluster_name" {
  description = "The name to use for all the cluster resources"
  type        = string
}

variable "db_address" {
  description = "The address of the database"
  type        = string
}

variable "db_port" {
  description = "The port of the database"
  type        = number
}

variable "instance_type" {
  description = "The type of EC2 instances to run (e.g. t3.micro)"
  type        = string
}

variable "min_size" {
  description = "The minimum number of EC2 instances in the ASG"
  type        = number
}

variable "max_size" {
  description = "The maximum number of EC2 instances in the ASG"
  type        = number
}

variable "server_text" {
  description = "The text the web server returns"
  type        = string
  default     = "Hello, World"
}
