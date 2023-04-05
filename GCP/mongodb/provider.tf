terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
    }
  }
}

provider "google" {
  region  = var.gcp_region
  project = var.gcp_project
}

provider "mongodbatlas" {
  public_key  = "${var.MONGODB_ATLAS_PUBLIC_KEY}"
  private_key = "${var.MONGODB_ATLAS_PRIVATE_KEY}"
}
