variable "names" {
  description = "A list of names"
  type        = list(string)
  default     = ["mario", "bowser", "toad"]
}

variable "weight_classes" {
  description = "Mario Kart characters and their weight class"
  type        = map(string)
  default = {
    mario  = "medium"
    bowser = "heavy"
    toad   = "light"
  }
}
