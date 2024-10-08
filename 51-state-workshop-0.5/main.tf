provider "aws" {
  region = "us-east-1"
}


# partial configuration. The other settings (e.g., bucket, region) are
# passed from a file via -backend-config arguments to 'terraform init'
terraform {
  backend "s3" {
    key = "workspaces-example/terraform.tfstate"
  }
}


resource "aws_instance" "example" {
  ami           = "ami-0d7d1c852f6af9831"
  instance_type = "t2.micro"
}
