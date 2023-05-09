resource "google_project_service" "run_api" {
  service            = "run.googleapis.com"
  disable_on_destroy = false
}
resource "google_project_service" "IAM-API" {
  service            = "iam.googleapis.com"
  disable_on_destroy = false

}
resource "google_project_service" "Manager-API" {
  service = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false

}
resource "google_project_service" "service_usage_api" {
  service = "serviceusage.googleapis.com"
  disable_on_destroy = false
}
resource "google_project_service" "artifact_registry_api" {
  service = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}
