output "public_ip" {
  value = aws_instance.main.public_ip
}

output "DNS" {
  value = aws_instance.main.public_dns
}

output "address" {
  value     = replace(data.aws_ecr_authorization_token.main.proxy_endpoint, "https://", "")
  sensitive = true
}
output "url" {
  value     = aws_ecr_repository.main.repository_url
  sensitive = true
}

output "username" {
  value     = data.aws_ecr_authorization_token.main.user_name
  sensitive = true
}

output "password" {
  value     = data.aws_ecr_authorization_token.main.password
  sensitive = true
}
output "image_name" {
  value = format("%v/%v:%v", local.ecr_address, var.repository_name, local.image_tag)
}
# output "image_tag" {
#   value = replace(docker_image.image.name, "test:", "")
# }

