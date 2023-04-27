data "google_iam_policy" "backend" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_v2_service_iam_policy" "backend" {
  location    = google_cloud_run_v2_service.backend.location
  project     = google_cloud_run_v2_service.backend.project
  name     = google_cloud_run_v2_service.backend.name

  policy_data = data.google_iam_policy.backend.policy_data
}


data "google_iam_policy" "frontend" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_v2_service_iam_policy" "frontend" {
  location    = google_cloud_run_v2_service.frontend.location
  project     = google_cloud_run_v2_service.frontend.project
  name     = google_cloud_run_v2_service.frontend.name

  policy_data = data.google_iam_policy.frontend.policy_data
}