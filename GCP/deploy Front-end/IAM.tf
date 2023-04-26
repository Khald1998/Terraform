data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.main.location
  project     = google_cloud_run_service.main.project
  service     = google_cloud_run_service.main.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
