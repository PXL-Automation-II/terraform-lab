terraform {
  source = "../../../modules/ec2-instance"
}
inputs = {
  instance_type = "t2.micro"
  instance_name = "example-server-stage"
}
