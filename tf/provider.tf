terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.34.0"
    }
  }
}

provider "google" {
  region      = "us-central1"
  project     = "yantra1"
  credentials = file("/Users/rajatkumar/personal/tws/terraform-end-to-end/tf/yantra1.json")
}
