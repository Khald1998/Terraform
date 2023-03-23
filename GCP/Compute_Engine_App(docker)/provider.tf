terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

provider "google" {
  region  = var.gcp_region
  project = var.gcp_project
}

provider "docker" {

}