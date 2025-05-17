resource "google_compute_network" "my-network" {
  name                    = "terraform-network-${var.env}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "my-subnetwork" {
  name          = "terraform-subnetwork-${var.env}"
  network       = google_compute_network.my-network.name
  ip_cidr_range = var.ip-range
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