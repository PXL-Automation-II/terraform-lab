# Automatically find the root terragrunt.hcl and inherit its
# configuration
include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/ec2-instance"
}
inputs = {
  instance_type = "t2.micro"
  instance_name = "example-server-dev"
}
