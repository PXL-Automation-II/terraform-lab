terraform {
  required_version = ">= 1.12.0"

  backend "s3" {
    key = "prod/services/webserver-cluster/terraform.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  # replace with your own repository: github.com/YOUR-USER/terraform-modules
  source = "github.com/PXL-Automation-II/tf-lab-modules//services/webserver-cluster?ref=v0.1.1"

  cluster_name           = "webservers-prod"
  db_remote_state_bucket = "terraform-pxl-state-1234" # the bucket from 00-backend-bootstrap
  db_remote_state_key    = "prod/data-storage/mysql/terraform.tfstate"

  instance_type = "t3.small"
  min_size      = 2
  max_size      = 4
}

resource "aws_autoscaling_schedule" "scale_out_in_morning" {
  scheduled_action_name  = "scale-out-during-business-hours"
  min_size               = 2
  max_size               = 4
  desired_capacity       = 4
  recurrence             = "0 9 * * *"
  time_zone              = "Europe/Brussels"
  autoscaling_group_name = module.webserver_cluster.asg_name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name  = "scale-in-at-night"
  min_size               = 2
  max_size               = 4
  desired_capacity       = 2
  recurrence             = "0 17 * * *"
  time_zone              = "Europe/Brussels"
  autoscaling_group_name = module.webserver_cluster.asg_name
}
