# resource "google_project_iam_binding" "Service_Account_Token_Creator" {
#   project = var.gcp_project
#   role    = "roles/iam.serviceAccountTokenCreator"

#   members = [
#     "user:${var.user_email}"
#   ]
#   #   lifecycle {
#   #   prevent_destroy = true
#   # }
# }



# resource "google_storage_bucket_iam_member" "Storage_Object_Admin" {
#   project = var.gcp_project
#   role    = "roles/storage.objectAdmin"

#   members = [
#     "user:${var.user_email}"
#     ,"serviceAccount:${google_compute_instance.main.service_account[0].email}"
#   ]

# }

# resource "google_storage_bucket_iam_member" "Storage_Object_Viewer" {
#   project = var.gcp_project
#   role    = "roles/storage.objectViewer"

#   members = [
#     "user:${var.user_email}"
#     ,"serviceAccount:${google_compute_instance.main.service_account[0].email}"
#   ]

# }


resource "google_storage_bucket_iam_member" "viewer" {
  bucket = "artifacts.terraform-31308.appspot.com"
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_compute_instance.main.service_account[0].email}"
}

resource "google_storage_bucket_iam_member" "Admin" {
  bucket = "artifacts.terraform-31308.appspot.com"
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_compute_instance.main.service_account[0].email}"
}