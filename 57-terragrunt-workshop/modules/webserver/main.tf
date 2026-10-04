data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "instance" {
  name        = "${var.environment}-webserver-sg"
  description = "Security group for ${var.environment} web server"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "HTTP from anywhere"
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Geen poort 22 / SSH nodig: beheer verloopt via AWS SSM Session Manager

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-webserver-sg"
    Environment = var.environment
  }
}

resource "aws_instance" "webserver" {
  ami                    = "ami-025d99823a4caad37"
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.instance.id]
  subnet_id              = tolist(data.aws_subnets.default.ids)[0]

  # Koppel LabInstanceProfile voor keyless access via SSM Session Manager
  iam_instance_profile = "LabInstanceProfile"

  user_data = templatefile("${path.module}/user-data.sh", {
    server_port = var.server_port
    environment = var.environment
  })

  tags = {
    Name        = var.instance_name
    Environment = var.environment
  }
}
