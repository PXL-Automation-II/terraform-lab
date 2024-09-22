resource "aws_instance" "example" {
  ami           = "ami-07eeacb3005b9beae"
  instance_type = "t2.micro"
}
