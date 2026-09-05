provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami                  = "ami-025d99823a4caad37"
  instance_type        = var.instance_type
  iam_instance_profile = "LabInstanceProfile"
  tags = {
    Name = var.instance_name
  }
}
