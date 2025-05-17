provider "google" {
  project     = "yantra1"
  region      = "us-central1"
  credentials = file("/Users/rajatkumar/personal/tws/terraform-end-to-end/tf/yantra1.json")
}
