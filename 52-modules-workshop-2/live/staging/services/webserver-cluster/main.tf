terraform {
  backend "s3" {
    key = "staging/services/webserver-cluster/terraform.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source       = "github.com/PXL-Automation-II/tf-lab-modules//services/webserver-cluster?ref=v0.0.4"
  cluster_name = "webservers-staging"
  # replace with your unique bucket name
  db_remote_state_bucket = "terraform-pxl-state"
  db_remote_state_key    = "staging/data-storage/mysql/terraform.tfstate"
  instance_type          = "t3.micro"
  min_size               = 2
  max_size               = 2
}

# Extra port, only in staging, for testing
resource "aws_vpc_security_group_ingress_rule" "allow_testing_inbound" {
  security_group_id = module.webserver_cluster.alb_security_group_id

  from_port   = 12345
  to_port     = 12345
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
}
