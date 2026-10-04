locals {
  # Parse the file path to extract the environment name: e.g., env
  # will be "dev" in the dev folder, "stage" in the stage folder, etc.
  # replace() turns Windows backslashes into forward slashes first.
  parsed = regex(".*/live/(?P<env>.*?)/.*", replace(get_terragrunt_dir(), "\\", "/"))
  env    = local.parsed.env
}

# Configure S3 as a remote backend
remote_state {
  backend = "s3"
  config = {
    bucket       = "pxl-example-bucket-${local.env}" # replace with a globally unique name
    region       = "us-east-1"
    key          = "${replace(path_relative_to_include(), "\\", "/")}/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
