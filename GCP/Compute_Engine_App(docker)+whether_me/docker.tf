resource "docker_image" "main" {
  name = "us-central1-docker.pkg.dev/${var.gcp_project}/${var.repository_name}/${var.image_name}:latest"
  build {
    context    = "${path.module}/Dockerize_me/."
    dockerfile = "Dockerfile"
    no_cache   = true
  }
}

resource "docker_registry_image" "main" {
  name          = docker_image.main.name
  keep_remotely = true
  depends_on = [ google_artifact_registry_repository.main ]
}


resource "google_artifact_registry_repository" "main" {
  location      = "us-central1"
  repository_id = var.repository_name
  description   = "docker repository"
  format        = "DOCKER"

}