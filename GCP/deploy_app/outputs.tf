output "backend_image_name" {
  value = docker_image.backend.name
}

output "uri" {
  value = google_cloud_run_v2_service.frontend.uri
}