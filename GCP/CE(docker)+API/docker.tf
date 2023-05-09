
resource "docker_image" "main" {
  name = "us-central1-docker.pkg.dev/${var.gcp_project}/${var.repository_name}/${var.image_name}:latest"
  build {
    context    = "${path.module}/api/."
    dockerfile = "Dockerfile"
    no_cache   = true
  }

}

resource "docker_registry_image" "main" {
  name          = docker_image.main.name
  keep_remotely = true
}



