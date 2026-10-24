terraform {
  required_version = ">= 1.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
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

resource "aws_security_group" "runner" {
  name        = "github-runner"
  description = "GitHub Actions runner: no inbound traffic, all outbound"
}

# The runner connects out to GitHub, AWS and the Terraform registry.
# Nothing connects in, so there is no ingress rule.
# trivy:ignore:AWS-0104 the runner must reach GitHub and AWS on the internet
resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.runner.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_instance" "runner" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.small"
  iam_instance_profile   = "LabInstanceProfile"
  vpc_security_group_ids = [aws_security_group.runner.id]

  user_data = templatefile("${path.module}/user-data.sh", {
    runner_version = var.runner_version
    runner_sha256  = var.runner_sha256
    repo_url       = var.repo_url
    runner_token   = var.runner_token
  })

  root_block_device {
    volume_size = 20
    encrypted   = true
  }

  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name = "github-runner"
  }

  lifecycle {
    # The token is only used at first boot, and a new Ubuntu image
    # should not replace a working runner.
    ignore_changes = [user_data, ami]
  }
}
