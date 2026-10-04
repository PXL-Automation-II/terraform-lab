include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "env" {
  path   = find_in_parent_folders("env.hcl")
  expose = true
}

terraform {
  source = "../../modules/webserver"
}

inputs = {
  environment   = include.env.locals.environment
  instance_type = include.env.locals.instance_type
  server_port   = include.env.locals.server_port
  instance_name = include.env.locals.instance_name
}
