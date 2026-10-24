terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
}

resource "aws_autoscaling_schedule" "scale_out_in_morning" {
  scheduled_action_name  = "scale-out-during-business-hours"
  min_size               = var.min_size
  max_size               = var.max_size
  desired_capacity       = var.max_size
  recurrence             = "0 9 * * *"
  time_zone              = "Europe/Brussels"
  autoscaling_group_name = var.asg_name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name  = "scale-in-at-night"
  min_size               = var.min_size
  max_size               = var.max_size
  desired_capacity       = var.min_size
  recurrence             = "0 17 * * *"
  time_zone              = "Europe/Brussels"
  autoscaling_group_name = var.asg_name
}
