resource "google_storage_bucket" "terraform-backend" {
  name          = "tf-state-backend-rk-${var.env}"
  location      = var.region
  project       = var.project-name
  force_destroy = true

}