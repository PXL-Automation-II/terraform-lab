terraform {
  backend "s3" {
    key = "examples/workspaces/terraform.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-025d99823a4caad37"
  instance_type = terraform.workspace == "default" ? "t3.medium" : "t3.micro"

  tags = {
    Name = "workspaces-example"
  }
}
