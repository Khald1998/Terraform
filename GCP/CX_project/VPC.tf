resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name          # defines the name of the VPC network
  auto_create_subnetworks = false                # disables automatic creation of subnets


  project = var.gcp_project          # sets the ID of the project where the VPC network will be created
}
resource "google_compute_subnetwork" "vpc_subnet" {
  name          = "vpc-subnet"
  region        = var.gcp_region
  network       = google_compute_network.vpc_network.self_link
  ip_cidr_range = "10.0.1.0/24"
}