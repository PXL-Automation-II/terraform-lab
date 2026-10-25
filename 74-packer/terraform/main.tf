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

variable "stage" {
  description = "Use the newest image with this Stage tag"
  type        = string
  default     = "dev"
}

# The newest image that Packer built in this account, for the chosen stage
data "aws_ami" "web" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "tag:Name"
    values = ["pxl-web"]
  }

  filter {
    name   = "tag:Stage"
    values = [var.stage]
  }
}

resource "aws_security_group" "web" {
  name        = "pxl-web"
  description = "HTTP from everywhere"
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.web.id
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.web.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web.id]

  tags = {
    Name = "pxl-web"
  }
}

output "ami" {
  value = "${data.aws_ami.web.name} (${data.aws_ami.web.id})"
}

output "url" {
  value = "http://${aws_instance.web.public_ip}"
}
