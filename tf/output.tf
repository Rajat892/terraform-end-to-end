output "publicIP" {
  #value = google_compute_instance.my-vm-for-each[0].network_interface[*].access_config[*].nat_ip
  value = [
    for i in google_compute_instance.my-vm-for-each : i.network_interface[*].access_config[*].nat_ip
  ]
}
