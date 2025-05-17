module "dev-infra" {
  source   = "/Users/rajatkumar/personal/tws/terraform-module/infra"
  env      = "dev"
  region   = "us-central1"
  zone     = "us-central1-b"
  machine  = "e2-standard-2"
  ip-range = "10.0.0.0/24"
}

module "prod-infra" {
  source   = "/Users/rajatkumar/personal/tws/terraform-module/infra"
  env      = "prod"
  region   = "us-central1"
  zone     = "us-central1-b"
  machine  = "e2-standard-2"
  ip-range = "10.1.0.0/24"
}

module "staging-infra" {
  source   = "/Users/rajatkumar/personal/tws/terraform-module/infra"
  env      = "stage"
  region   = "us-central1"
  zone     = "us-central1-b"
  machine  = "e2-standard-2"
  ip-range = "192.168.0.0/24"
}
