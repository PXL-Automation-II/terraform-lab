terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket = "terraform-pxl-state"
    key    = "staging/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-pxl-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-pxl"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t3.micro"
  skip_final_snapshot = true
  db_name             = "example_database"
  # How do we set the username and password?
  username = var.db_username
  password = var.db_password
}
