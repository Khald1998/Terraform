# This block declares a data source to fetch available Google Compute Engine zones
data "google_compute_zones" "available_zones" {}

# This block declares a resource for creating a static IP address
resource "google_compute_address" "static" {
  name = "apache"  # Name of the static IP address resource
}

# This block declares a resource for creating a Google Compute Engine instance
resource "google_compute_instance" "apache" {
  name = "apache"  # Name of the instance
  zone = data.google_compute_zones.available_zones.names[0]  # The zone where the instance will be created. We are using the first available zone from the data source declared above.
  tags = ["allow-http"]  # Network tags associated with the instance

  machine_type = "e2-micro"  # The machine type for the instance

  # This block declares a boot disk for the instance with an Ubuntu image
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  # This block declares a network interface for the instance
  network_interface {
    network = "default"  # The name of the network where the instance will be created

    # This block declares a network access configuration for the network interface using the static IP address resource created above
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  metadata_startup_script = file("startup_script.sh")  # Path to the startup script for the instance
}

# This block declares a firewall rule to allow incoming TCP traffic on port 8080 and SSH port to the instance
resource "google_compute_firewall" "allow_tcp_and_ssh" {
  name    = "allow-tcp-and-ssh-rule" # Name of the firewall rule
  network = "default" # The network where the firewall rule will be created

  # This block declares a rule to allow incoming TCP traffic on port 8080
  allow {
    ports    = ["8080"]
    protocol = "tcp"
  }

  # This block declares a rule to allow incoming SSH traffic
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }

  target_tags = ["allow-tcp-and-ssh"] # Network tags associated with the firewall rule

  priority = 1000 # Priority of the firewall rule
}

