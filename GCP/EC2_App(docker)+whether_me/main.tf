resource "google_compute_network" "main" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  
}

resource "google_compute_subnetwork" "main" {
  name          = "main-subnet"
  region        = "us-central1"
  network       = google_compute_network.main.self_link
  ip_cidr_range = "10.0.1.0/24"
}

resource "google_compute_firewall" "instance" {
  name    = "shh"
  network = google_compute_network.main.self_link

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "8080"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "example-instance" {
  name         = "example-instance"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.main.self_link
  }


}
