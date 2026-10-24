include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "env" {
  path   = find_in_parent_folders("env.hcl")
  expose = true
}

terraform {
  # replace with your own repository: github.com/YOUR-USER/terraform-modules
  source = "github.com/PXL-Automation-II/tf-lab-modules//services/asg-schedule?ref=v1.0.1"
}

dependency "cluster" {
  config_path = "../webserver-cluster"

  mock_outputs = {
    asg_name = "mock-asg"
  }
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
}

inputs = {
  asg_name = dependency.cluster.outputs.asg_name
  min_size = include.env.locals.min_size
  max_size = include.env.locals.max_size
}
