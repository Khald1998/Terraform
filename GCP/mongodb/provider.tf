terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  region  = var.gcp_region
  project = var.gcp_project
}

