resource "google_artifact_registry_repository" "main" {
  location      = "us-central1"
  repository_id = var.repository_name
  description   = "docker repository"
  format        = "DOCKER"

}






resource "google_cloud_run_v2_service" "main" {
  name     = "cloudrun-service"
  location = "us-central1"


  template {
      containers {
        image = docker_image.main.name
        # image = "us-docker.pkg.dev/cloudrun/container/hello"
      }
  }

  depends_on = [
    docker_registry_image.main
  ]
}
