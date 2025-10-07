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
  ami           = "ami-0360c520857e3138f"
  instance_type = "t3.micro"
}
