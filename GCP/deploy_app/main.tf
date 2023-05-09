resource "google_artifact_registry_repository" "main" {
  location      = "us-central1"
  repository_id = var.repository_name
  description   = "docker repository"
  format        = "DOCKER"

}

resource "google_cloud_run_v2_service" "backend" {
  name     = "backend"
  location = "us-central1"


  template {
    containers {
      image = docker_image.backend.name
        ports {
          container_port = 8080
        }
    }
  }

  depends_on = [
    docker_registry_image.backend
  ]
}


resource "google_cloud_run_v2_service" "frontend" {
  name     = "frontend"
  location = "us-central1"


  template {

    containers {
      image = docker_image.frontend.name
      env {
        name  = "VITE_URL"
        value = google_cloud_run_v2_service.backend.uri
      }
        ports {
          container_port = 3000
        }
    }
  }

  depends_on = [
    docker_registry_image.frontend
    , google_cloud_run_v2_service.backend
  ]
}
