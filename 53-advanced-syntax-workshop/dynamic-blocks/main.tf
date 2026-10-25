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

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

# The Availability Zones where t3.micro instances exist
data "aws_ec2_instance_type_offerings" "t3_micro" {
  location_type = "availability-zone"

  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }
}

resource "aws_launch_template" "example" {
  name          = "dynamic-blocks-example"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
}

# An ASG with 0 instances: enough to see the tags, and it costs nothing
resource "aws_autoscaling_group" "example" {
  name               = "dynamic-blocks-example"
  availability_zones = data.aws_ec2_instance_type_offerings.t3_micro.locations
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
