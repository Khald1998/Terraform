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

resource "google_storage_bucket_iam_member" "viewer" {
  bucket = "artifacts.terraform-31308.appspot.com"
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.registry_access.email}"
  depends_on = [
    google_service_account.registry_access
  ]

}

resource "google_storage_bucket_iam_member" "Admin" {
  bucket = "artifacts.terraform-31308.appspot.com"
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.registry_access.email}"
  depends_on = [
    google_service_account.registry_access
  ]
}


resource "google_project_iam_member" "viewer" {
  project = var.gcp_project
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.registry_access.email}"
  depends_on = [
    google_service_account.registry_access
  ]
}
resource "google_project_iam_member" "Admin" {
  project = var.gcp_project
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${google_service_account.registry_access.email}"
  depends_on = [
    google_service_account.registry_access
  ]
}
resource "google_project_iam_member" "networkAdmin" {
  project = var.gcp_project
  role    = "roles/compute.networkAdmin"
  member  = "serviceAccount:${google_service_account.registry_access.email}"
  depends_on = [
    google_service_account.registry_access
  ]
}
resource "google_project_iam_member" "instanceAdmin" {
  project = var.gcp_project
  role    = "roles/compute.instanceAdmin"
  member  = "serviceAccount:${google_service_account.registry_access.email}"
  depends_on = [
    google_service_account.registry_access
  ]
}
resource "google_project_iam_member" "gcr-pull-storage-admin" {
  project = var.gcp_project
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.registry_access.email}"
}

