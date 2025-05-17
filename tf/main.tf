resource "google_compute_network" "my-network" {
  name                    = "terraform-network-${var.env}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "my-subnetwork" {
  name          = "terraform-subnetwork-${var.env}"
  network       = google_compute_network.my-network.name
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
}

resource "google_compute_firewall" "my-fw" {
  name    = "test-firewall-${var.env}"
  network = google_compute_network.my-network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "22", "1000-2000"]
  }
  source_ranges = ["0.0.0.0/0"]
}

# resource "google_compute_instance" "my-vm" {
#   name         = "terraform-vm"
#   zone         = "us-central1-b"
#   machine_type = "e2-standard-2"
#   network_interface {
#     network    = google_compute_network.my-network.id
#     subnetwork = google_compute_subnetwork.my-subnetwork.name
#     access_config {}
#   }
#   boot_disk {
#     initialize_params {
#       image = "ubuntu-minimal-2504-plucky-amd64-v20250430"
#     }
#   }
#   metadata_startup_script = file("script.sh")
#   tags                    = ["http-server", "https-server"]
# }