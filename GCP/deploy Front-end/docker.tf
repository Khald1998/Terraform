
resource "docker_image" "main" {
  name = "us-central1-docker.pkg.dev/${var.gcp_project}/${var.repository_name}/${var.image_name}:latest"
  build {
    context    = "${path.module}/backend/."
    dockerfile = "Dockerfile"
    no_cache   = true
  }

}

resource "docker_registry_image" "main" {
  name          = docker_image.main.name
  keep_remotely = true

}



# docker tag backend us-central1-docker.pkg.dev/terraform-31308/my-docker-repository/backend:latest
# docker push us-central1-docker.pkg.dev/terraform-31308/my-docker-repository/backend:latest