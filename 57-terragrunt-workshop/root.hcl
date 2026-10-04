remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    bucket       = "terraform-pxl-tglab-state" # replace with a globally unique name
    key          = "${replace(path_relative_to_include(), "\\", "/")}/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = file("provider.tf")
}
