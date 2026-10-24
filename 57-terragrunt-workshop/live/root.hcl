remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    bucket       = "terraform-pxl-tg-state-1234" # replace 1234 with something unique: bucket names are global
    key          = "${replace(path_relative_to_include(), "\\", "/")}/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region = "us-east-1"
}
EOF
}
