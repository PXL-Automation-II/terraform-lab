provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = var.instance_type
  tags = {
    Name = var.instance_name
  }
}
