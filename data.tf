data "google_client_config" "default" {}

data "google_container_cluster" "default" {
  name     = var.cluster_name
  location = var.cluster_location
}
