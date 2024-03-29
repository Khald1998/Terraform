output "instance_external_ip" {
  value = google_compute_instance.main.network_interface[0].access_config[0].nat_ip
}

output "image_name" {
  value = docker_image.main.name
}

output "google_service_account" {
  value = google_service_account.registry_access.email
}
