include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "env" {
  path   = find_in_parent_folders("env.hcl")
  expose = true
}

terraform {
  # replace with your own repository: github.com/YOUR-USER/terraform-modules
  source = "github.com/PXL-Automation-II/tf-lab-modules//services/webserver-cluster?ref=v1.0.0"
}

dependency "mysql" {
  config_path = "../../data-storage/mysql"

  # Placeholder values for plan and validate, before the database exists
  mock_outputs = {
    address = "mock-address"
    port    = 3306
  }
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
}

inputs = {
  cluster_name  = "webservers-${include.env.locals.environment}"
  db_address    = dependency.mysql.outputs.address
  db_port       = dependency.mysql.outputs.port
  instance_type = include.env.locals.instance_type
  min_size      = include.env.locals.min_size
  max_size      = include.env.locals.max_size
}
