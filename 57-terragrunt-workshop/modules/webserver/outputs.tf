output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.webserver.id
}

output "public_ip" {
  description = "Public IP address of the web server"
  value       = aws_instance.webserver.public_ip
}

output "public_dns" {
  description = "Public DNS name of the web server"
  value       = aws_instance.webserver.public_dns
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.instance.id
}
