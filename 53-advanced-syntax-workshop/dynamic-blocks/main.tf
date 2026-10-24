terraform {
  required_version = ">= 1.12.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_launch_template" "example" {
  name          = "dynamic-blocks-example"
  image_id      = "ami-025d99823a4caad37"
  instance_type = "t3.micro"
}

# An ASG with 0 instances: enough to see the tags, and it costs nothing
resource "aws_autoscaling_group" "example" {
  name               = "dynamic-blocks-example"
  availability_zones = ["us-east-1a", "us-east-1b"]
  min_size           = 0
  max_size           = 0

  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "dynamic-blocks-example"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = {
      for key, value in var.custom_tags :
      key => upper(value)
      if key != "Name"
    }

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}
