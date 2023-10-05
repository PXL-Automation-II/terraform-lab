output "alb_dns_name" {
  value       = aws_lb.example.dns_name
  description = "The public IP address of the web server"
}
