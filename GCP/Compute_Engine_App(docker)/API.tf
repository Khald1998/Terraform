resource "google_project_service" "gcr_api" {
  project = var.gcp_project
  service = "containerregistry.googleapis.com"
  # lifecycle {
  #   prevent_destroy = true
  # }
}