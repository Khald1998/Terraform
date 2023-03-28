resource "google_service_account" "registry_access" {
  account_id   = "registry-access"
  display_name = "Service account for accessing the Container Registry"
}
resource "google_project_iam_member" "registry_access" {
  project = var.gcp_project
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.registry_access.email}"
}
resource "google_service_account_key" "registry_access" {
  service_account_id = google_service_account.registry_access.id
#   private_key_type   = "json"
}
