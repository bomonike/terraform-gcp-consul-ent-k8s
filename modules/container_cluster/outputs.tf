output "compute_subnetwork_id" {
  value = google_compute_subnetwork.this.id
}

output "container_cluster_id" {
  value = google_container_cluster.this.id
}

output "container_cluster_name" {
  value = google_container_cluster.this.name
}

output "container_cluster_self_link" {
  value = google_container_cluster.this.self_link
}
