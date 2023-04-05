resource "google_project_iam_binding" "Service_Account_Token_Creator" {
  project = var.gcp_project
  role    = "roles/iam.serviceAccountTokenCreator"
  members = [
  "user:${var.user_email}"
  ,"serviceAccount:${google_service_account.registry_access.email}"
  ]
  depends_on = [
    google_service_account.registry_access
  ]
}
resource "google_project_iam_binding" "serviceAccountUser" {
  project = var.gcp_project
  role    = "roles/iam.serviceAccountUser"
  members = [
  "user:${var.user_email}"
  ,"serviceAccount:${google_service_account.registry_access.email}"
  ]

}
resource "google_project_iam_binding" "serviceAccountAdmin" {
  project = var.gcp_project
  role    = "roles/iam.serviceAccountAdmin"
  members = [
  "user:${var.user_email}"
  ,"serviceAccount:${google_service_account.registry_access.email}"
  ]

}