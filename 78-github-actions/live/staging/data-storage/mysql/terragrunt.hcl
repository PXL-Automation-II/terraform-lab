include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "env" {
  path   = find_in_parent_folders("env.hcl")
  expose = true
}

terraform {
  # replace with your own repository: github.com/YOUR-USER/terraform-modules
  source = "github.com/PXL-Automation-II/tf-lab-modules//data-storage/mysql?ref=v1.0.2"
}

inputs = {
  identifier_prefix = "${include.env.locals.environment}-mysql-"
}
