resource "google_service_account" "registry_access" {
  account_id   = "registry-access"
  display_name = "Service account for accessing the Container Registry"
}

resource "google_service_account_key" "registry_access" {
  service_account_id = google_service_account.registry_access.id
  private_key_type   = "TYPE_GOOGLE_CREDENTIALS_FILE"
}

resource "local_file" "registry_access_key" {
  content  = base64decode(google_service_account_key.registry_access.private_key)
  filename = "registry-access-key.json"
}



