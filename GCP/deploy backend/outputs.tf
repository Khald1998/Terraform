output "image_name" {
  value = docker_image.main.name
}

output "uri" {
  value = google_cloud_run_v2_service.main.uri
}