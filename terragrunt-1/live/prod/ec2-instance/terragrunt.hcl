terraform {
  source = "../../../modules/ec2-instance"
}
inputs = {
  instance_type = "m4.large"
  instance_name = "example-server-prod"
}
