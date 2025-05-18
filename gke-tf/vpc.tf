resource "google_compute_network" "my-network" {
  name                    = "gke-network-${local.env}"
  auto_create_subnetworks = false
  project = local.project-name
}

resource "google_compute_subnetwork" "my-subnetwork" {
  name          = "gke-subnetwork-${local.env}"
  network       = google_compute_network.my-network.name
  ip_cidr_range = "10.0.0.0/24"
  region        = local.region
  project = local.project-name

  private_ip_google_access = true
  depends_on = [
    google_compute_network.my-network
  ]
  secondary_ip_range {
    range_name    = "private-pods"
    ip_cidr_range = local.secondary_pods_ip_range
  }

  secondary_ip_range {
    range_name    = "private-services"
    ip_cidr_range = local.secondary_services_ip_range
  }
}

resource "google_compute_firewall" "my-fw" {
  name    = "gke-firewall-${local.env}"
  network = google_compute_network.my-network.name
  project = local.project-name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "22", "1000-2000"]
  }
  source_ranges = ["0.0.0.0/0"]
}
