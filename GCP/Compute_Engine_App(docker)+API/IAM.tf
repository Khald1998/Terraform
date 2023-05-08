resource "google_project_iam_member" "reader" {
  project = var.gcp_project
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.registry_access.email}"
}
resource "google_project_iam_member" "writer" {
  project = var.gcp_project
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.registry_access.email}"
}
resource "google_project_iam_member" "repoAdmin" {
  project = var.gcp_project
  role    = "roles/artifactregistry.repoAdmin"
  member  = "serviceAccount:${google_service_account.registry_access.email}"
}
resource "google_project_iam_member" "admin" {
  project = var.gcp_project
  role    = "roles/artifactregistry.admin"
  member  = "serviceAccount:${google_service_account.registry_access.email}"
}