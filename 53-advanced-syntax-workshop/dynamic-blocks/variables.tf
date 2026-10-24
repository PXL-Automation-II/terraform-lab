variable "custom_tags" {
  description = "Extra tags for the ASG and its instances"
  type        = map(string)
  default = {
    Owner     = "team-pxl"
    ManagedBy = "terraform"
  }
}
