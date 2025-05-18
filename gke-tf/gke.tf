data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.gke_cluster.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate)
}

# gke cluster
resource "google_container_cluster" "gke-cluster" {
  name                     = local.name
  location                 = local.region
  deletion_protection      = false
  remove_default_node_pool = false
  project = local.project-name
  initial_node_count       = 1
  # node_version             = local.node_version
  network                  = google_compute_network.my-network.name
  subnetwork               = google_compute_subnetwork.my-subnetwork.name
  default_snat_status {
    disabled = false
  }
  workload_identity_config {
    workload_pool = "${local.project-name}.svc.id.goog"
  }
  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = local.master-authorized-network-config
      content {
        cidr_block   = cidr_blocks.value["cidr_block"]
        display_name = cidr_blocks.value["display_name"]
      }

    }
  }


  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"



  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = local.master_ipv4_cidr_block
    # private_endpoint_subnetwork = var.network-module.subnet
  }

  ip_allocation_policy {

    cluster_secondary_range_name  = "private-pods"
    services_secondary_range_name = "private-services"

  }

  release_channel {

    channel = "UNSPECIFIED"

  }


  depends_on = [
    google_compute_network.my-network,
    google_compute_subnetwork.my-subnetwork

  ]

}


data "google_service_account" "gke-cluster-sa" {
  account_id = "terraform@yantra1.iam.gserviceaccount.com"
}


resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "terraform-node-pool"
  project = local.project-name
  cluster    = google_container_cluster.gke-cluster.id
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "n1-standard-4"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = data.google_service_account.gke-cluster-sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}