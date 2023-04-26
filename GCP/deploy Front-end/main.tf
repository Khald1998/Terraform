# Create a new VPC network
resource "google_compute_network" "main" {
  name                    = var.vpc_name # The name of the VPC network
  auto_create_subnetworks = false        # Do not automatically create subnets
  routing_mode            = "REGIONAL"   # Use regional routing for the network
}

# Create a new subnet in the VPC network
resource "google_compute_subnetwork" "main" {
  name          = "main-subnet"                         # The name of the subnet
  region        = "us-central1"                         # The region where the subnet will be created
  network       = google_compute_network.main.self_link # The self-link URL of the parent network
  ip_cidr_range = "10.0.1.0/24"                         # The IP range for the subnet
}

# Create a firewall rule to allow SSH, HTTP, and HTTPS traffic to instances in the network
resource "google_compute_firewall" "main" {
  name    = "allow-all"                           # The name of the firewall rule
  network = google_compute_network.main.self_link # The self-link URL of the network to apply the rule to

  allow {
    protocol = "tcp"                # The protocol to allow traffic for
    ports    = ["22", "80", "8080"] # The ports to allow traffic for
  }


  source_ranges = ["0.0.0.0/0"] # The IP ranges to allow traffic from

}

resource "google_artifact_registry_repository" "main" {
  location      = "us-central1"
  repository_id = var.repository_name
  description   = "docker repository"
  format        = "DOCKER"


}


resource "google_project_service" "run_api" {
  service = "run.googleapis.com"

}



resource "google_cloud_run_service" "main" {
  name     = "cloudrun-service"
  location = "us-central1"


  template {
    spec {
      # service_account_name = google_service_account.cloud-run.email
      containers {
        # image = docker_image.main.name
        image = "us-docker.pkg.dev/cloudrun/container/hello"
        //us-central1-docker.pkg.dev/terraform-31308/my-docker-repository/backend
      }
    }
  }
    traffic {
    percent         = 100
    latest_revision = true
  }
  depends_on = [
    google_project_service.run_api
    , docker_image.main
  ]
}
