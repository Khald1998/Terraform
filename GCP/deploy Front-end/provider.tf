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
  credentials = file("C:/Users/arraa/AppData/Roaming/gcloud/terraform-31308-key.json")
}

provider "docker" {
  registry_auth {
    address = "us-central1-docker.pkg.dev"
    config_file = pathexpand("C:/Users/arraa/.docker/config.json")
  }
}