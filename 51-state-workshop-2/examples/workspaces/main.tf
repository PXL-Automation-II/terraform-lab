terraform {
  backend "s3" {
    key = "examples/workspaces/terraform.tfstate"
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

resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = terraform.workspace == "default" ? "t3.medium" : "t3.micro"

  tags = {
    Name = "workspaces-example"
  }
}
