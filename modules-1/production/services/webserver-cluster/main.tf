terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket = "terraform-pxl-state"
    key    = "prod/services/webserver-cluster/terraform.tfstate"
    region = "us-east-1"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-pxl-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"
  cluster_name           = "webservers-prod"
  # replace with your unique bucket name
  db_remote_state_bucket = "terraform-pxl-state"
  db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 10
}
