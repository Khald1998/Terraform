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
  name    = "allow-all"                                   # The name of the firewall rule
  network = google_compute_network.main.self_link    # The self-link URL of the network to apply the rule to

  allow {
    protocol = "tcp"                             # The protocol to allow traffic for
    ports    = ["22", "80", "8080"]             # The ports to allow traffic for
  }


  source_ranges = ["0.0.0.0/0"]                   # The IP ranges to allow traffic from

}

resource "google_artifact_registry_repository" "main" {
  location      = "us-central1"
  repository_id = var.repository_name
  description   = "docker repository"
  format        = "DOCKER"

  # docker_config {
  #   immutable_tags = true
  # }
}

# Create a new virtual machine instance in the subnet
resource "google_compute_instance" "main" {
  name         = "my-api"              # The name of the instance
  machine_type = "n1-standard-1"                 # The machine type to use
  zone         = "us-central1-a"                 # The zone to create the instance in
  allow_stopping_for_update = true


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

  service_account {
    email  = google_service_account.registry_access.email
    scopes = ["cloud-platform"]
  }
  connection {
    type        = "ssh"
    user        = "${var.ssh_user}"
    private_key = "${tls_private_key.example_key.private_key_pem}"
    host        = "${google_compute_instance.main.network_interface.0.access_config.0.nat_ip}"
  }
  provisioner "file" {
    source = "registry-access-key.json"
    destination = "/home/${var.ssh_user}/service_account.json"
  }

  # Add a startup script to run when the instance boots

  metadata_startup_script = templatefile("${path.module}/data.sh", {
    url  = docker_image.main.name
    USER = var.ssh_user
  })

    depends_on = [
    google_service_account.registry_access
    ,google_service_account_key.registry_access
  ]
}


resource "tls_private_key" "example_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "google_compute_project_metadata_item" "ssh-keys" {
  key   = "ssh-keys"
  value = "${var.ssh_user}:${tls_private_key.example_key.public_key_openssh}"
}

