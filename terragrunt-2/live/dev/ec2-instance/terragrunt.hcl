# Automatically find root.hcl and inherit its configuration
include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/ec2-instance"
}
inputs = {
  instance_type = "t3.micro"
  instance_name = "example-server-dev"
}
