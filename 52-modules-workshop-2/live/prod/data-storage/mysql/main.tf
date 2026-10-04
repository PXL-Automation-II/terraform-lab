terraform {
  backend "s3" {
    key = "prod/data-storage/mysql/terraform.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-pxl"
  engine              = "mysql"
  allocated_storage   = 20
  instance_class      = "db.t3.micro"
  skip_final_snapshot = true
  db_name             = "example_database"
  username            = var.db_username
  password            = var.db_password
}
