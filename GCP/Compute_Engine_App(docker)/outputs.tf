# output "instance_external_ip" {
#   value = google_compute_instance.main.network_interface[0].access_config[0].nat_ip
# }

output "image_name" {
  value = docker_image.main.name
}

output "email" {
  value = google_compute_instance.main.service_account[0].email
}
