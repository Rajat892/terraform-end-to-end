resource "google_compute_instance" "my-vm" {
  name         = "terraform-vm-${var.env}"
  zone         = var.zone
  machine_type = var.machine
  allow_stopping_for_update = true
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
