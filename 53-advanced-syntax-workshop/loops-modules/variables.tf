variable "names" {
  description = "Create log groups with these names"
  type        = list(string)
  default     = ["mario", "bowser", "toad"]
}
