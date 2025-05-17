terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.34.0"
    }
  }
  backend "gcs" {
    bucket = "tf-state-backend-rk"
  }
}

provider "google" {
  region      = "us-central1"
  project     = "yantra1"
  credentials = file("yantra1.json") 
}
