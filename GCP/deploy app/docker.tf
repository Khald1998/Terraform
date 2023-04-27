
resource "docker_image" "backend" {
  name = "us-central1-docker.pkg.dev/${var.gcp_project}/${var.repository_name}/backend:latest"
  build {
    context    = "${path.module}/backend/."
    dockerfile = "Dockerfile"
    no_cache   = true
  }
}

resource "docker_image" "frontend" {
  name = "us-central1-docker.pkg.dev/${var.gcp_project}/${var.repository_name}/frontend:latest"
  build {
    context    = "${path.module}/frontend/."
    dockerfile = "Dockerfile"
    no_cache   = true
  }
}

resource "docker_registry_image" "backend" {
  name          = docker_image.backend.name
  keep_remotely = true
  depends_on = [
    docker_image.backend
    ,google_artifact_registry_repository.main
  ]
}

resource "docker_registry_image" "frontend" {
  name          = docker_image.frontend.name
  keep_remotely = true
  depends_on = [
    docker_image.frontend
    ,google_artifact_registry_repository.main
  ]
}



# docker tag backend us-central1-docker.pkg.dev/terraform-31308/my-docker-repository/backend:latest
# docker push us-central1-docker.pkg.dev/terraform-31308/my-docker-repository/backend:latest