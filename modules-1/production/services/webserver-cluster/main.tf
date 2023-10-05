provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"
  cluster_name           = "webservers-prod"
  # replace with your unique bucket name
  db_remote_state_bucket = "terraform-pxl-state"
  db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"
}
