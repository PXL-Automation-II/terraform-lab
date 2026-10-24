terraform {
  required_version = ">= 1.12.0"

  backend "s3" {
    key = "prod/data-storage/mysql/terraform.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "mysql" {
  source = "../../../../modules/data-storage/mysql"

  identifier_prefix = "prod-mysql-"
  db_username       = var.db_username
  db_password       = var.db_password
}
