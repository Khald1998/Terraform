variable "gcp_region" {
  type        = string
  description = "Region to use for GCP provider"
  default     = "us-central1"
}

variable "gcp_project" {
  type        = string
  description = "Project to use for this config"
  default     = "terraform-386115"
}

variable "repository_name" {
  default = "my-docker-repository-3"
}
