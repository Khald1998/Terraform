# Create a new VPC network
resource "google_compute_network" "main" {
  name                    = var.vpc_name     # The name of the VPC network
  auto_create_subnetworks = false            # Do not automatically create subnets
  routing_mode            = "REGIONAL"       # Use regional routing for the network
}

# Create a new subnet in the VPC network
resource "google_compute_subnetwork" "main" {
  name          = "main-subnet"                   # The name of the subnet
  region        = "us-central1"                   # The region where the subnet will be created
  network       = google_compute_network.main.self_link  # The self-link URL of the parent network
  ip_cidr_range = "10.0.1.0/24"                   # The IP range for the subnet
}

# Create a firewall rule to allow SSH, HTTP, and HTTPS traffic to instances in the network
resource "google_compute_firewall" "main" {
  name    = "shh"                                   # The name of the firewall rule
  network = google_compute_network.main.self_link    # The self-link URL of the network to apply the rule to

  allow {
    protocol = "tcp"                             # The protocol to allow traffic for
    ports    = ["22", "80", "8080"]             # The ports to allow traffic for
  }
  source_ranges = ["0.0.0.0/0"]                   # The IP ranges to allow traffic from
}

# Create a new virtual machine instance in the subnet
resource "google_compute_instance" "main" {
  name         = "example-instance"              # The name of the instance
  machine_type = "n1-standard-1"                 # The machine type to use
  zone         = "us-central1-a"                 # The zone to create the instance in

  # Configure the boot disk for the instance
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts" # The image to use for the boot disk
    }
  }

  # Configure the network interface for the instance
  network_interface {
    subnetwork = google_compute_subnetwork.main.self_link  # The self-link URL of the subnet to attach the instance to

    access_config {}                                      # Configure external IP address for the instance
  }

  # Add a startup script to run when the instance boots
  metadata_startup_script = file("data.sh")
}

