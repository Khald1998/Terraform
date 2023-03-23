resource "google_project_iam_binding" "Service_Account_Token_Creator" {
  project = var.gcp_project
  role    = "roles/iam.serviceAccountTokenCreator"

  members = [
    "user:${var.user_email}"
  ]
}


