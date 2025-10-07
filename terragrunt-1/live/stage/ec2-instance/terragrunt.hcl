terraform {
  source = "../../../modules/ec2-instance"
}
inputs = {
  instance_type = "t3.micro"
  instance_name = "example-server-stage"
}
