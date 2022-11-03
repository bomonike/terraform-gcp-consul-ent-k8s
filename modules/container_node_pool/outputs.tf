output "container_node_pool_id" {
  value = google_container_node_pool.this.id
}

output "sa_account_id" {
  value = google_service_account.this.account_id
}

output "sa_email" {
  value = google_service_account.this.email
}
