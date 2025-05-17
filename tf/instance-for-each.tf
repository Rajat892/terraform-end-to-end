resource "google_compute_instance" "my-vm-for-each" {
  for_each     = toset(["terraform-vm-1-${var.env}", "terraform-vm-2-${var.env}"])
  name         = each.key
  zone         = var.zone
  machine_type = "e2-standard-2"
  network_interface {
    network    = google_compute_network.my-network.id
    subnetwork = google_compute_subnetwork.my-subnetwork.name
    access_config {}
  }
  boot_disk {
    initialize_params {
      image = "ubuntu-minimal-2504-plucky-amd64-v20250430"
    }
  }
  metadata_startup_script = file("script.sh")
  tags                    = ["http-server", "https-server"]
}
