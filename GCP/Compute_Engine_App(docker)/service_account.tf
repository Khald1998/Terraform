resource "google_service_account" "registry_access" {
  account_id   = "registry-access"
  display_name = "Service account for accessing the Container Registry"
}

# resource "google_service_account_key" "registry_access" {
#   service_account_id = google_service_account.registry_access.id
# #   private_key_type   = "json"
# }
