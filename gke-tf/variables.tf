locals {
  zone             = "us-central1-b"
  region           = "us-central1"
  ip-range         = "10.0.0.0/24"
  env              = "dev"
  name             = "terraform-cluster"
  project-name     = "yantra1"
  nodepool-machine = "n1-standard-8"
  master-authorized-network-config = [{
    cidr_block   = "103.109.73.26/32"
    display_name = "terraform-authorized-network"
  }]
  node_version           = "1.27.9-gke.1000"
  min_master_version     = "1.27.9-gke.1000"
  master_ipv4_cidr_block = "10.0.3.0/28"
  subnet_ip_cidr_range        = "10.0.0.0/28"
  secondary_pods_ip_range     = "10.0.1.0/24"
  secondary_services_ip_range = "10.0.2.0/24"
}
