data "google_iam_policy" "main" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_v2_service_iam_policy" "main" {
  location    = google_cloud_run_v2_service.main.location
  project     = google_cloud_run_v2_service.main.project
  name     = google_cloud_run_v2_service.main.name

  policy_data = data.google_iam_policy.main.policy_data
}