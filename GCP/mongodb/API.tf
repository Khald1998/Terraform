# resource "google_project_service" "atlas_api" {
#   project = var.gcp_project
#   service = "mongodb-atlas.googleapis.com"
#   depends_on = [
#     google_project_iam_binding.serviceAccountAdmin
#   ]
# }
