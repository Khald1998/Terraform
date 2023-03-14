output "public_ip" {
  value = aws_instance.main.public_ip
}

output "DNS" {
  value = aws_instance.main.public_dns
}