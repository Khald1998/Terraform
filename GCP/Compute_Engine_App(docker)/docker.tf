resource "time_static" "tag" {}

resource "docker_image" "main" {
  name = "gcr.io/${var.gcp_project}/${var.image_name}:${time_static.tag.unix}"
  build {
    context    = "${path.module}/Dockerize_me/."
    dockerfile = "Dockerfile"
    no_cache   = true
  }
  depends_on = [
    google_project_service.gcr_api
  ]
}

resource "docker_registry_image" "main" {
  name          = docker_image.main.name
  keep_remotely = true
  depends_on = [
    google_project_service.gcr_api
  ]
}