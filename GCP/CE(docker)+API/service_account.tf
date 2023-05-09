resource "google_service_account" "registry_access" {
  account_id   = "registry-access"
  display_name = "Service account for accessing the Container Registry"
}
