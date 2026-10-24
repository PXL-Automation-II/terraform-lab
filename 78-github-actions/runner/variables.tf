variable "repo_url" {
  description = "The repository this runner works for, for example https://github.com/YOUR-USER/tf-ci-example"
  type        = string
}

variable "runner_token" {
  description = "Registration token from the repository's runner settings. It expires after one hour."
  type        = string
  sensitive   = true
}

variable "runner_version" {
  description = "Version of the GitHub Actions runner"
  type        = string
  default     = "2.338.1"
}

variable "runner_sha256" {
  description = "SHA-256 checksum of actions-runner-linux-x64-<version>.tar.gz, from the release page"
  type        = string
  default     = "08e9ccb3604d2462c24b5e33604dc30810296ca15cc65f23cffd4317eb144c37"
}
