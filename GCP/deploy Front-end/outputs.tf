output "instance_external_ip" {
  value = google_compute_instance.main.network_interface[0].access_config[0].nat_ip
}

output "image_name" {
  value = docker_image.main.name
}

output "google_service_account" {
  value = google_service_account.registry_access.email
}

# output "private_key" {
#   value = nonsensitive(base64decode(google_service_account_key.registry_access.private_key))
# }
# output "pass" {
#   value = nonsensitive(data.google_client_config.default.access_token)
# }
