resource "google_service_account" "this" {
  account_id = var.sa_node_name
}

resource "google_project_iam_member" "service_account_log_writer" {
  project = var.project

  role   = "roles/logging.logWriter"
  member = "serviceAccount:${google_service_account.this.email}"
}

resource "google_project_iam_member" "service_account_metric_writer" {
  project = var.project

  role   = "roles/monitoring.metricWriter"
  member = "serviceAccount:${google_service_account.this.email}"
}

resource "google_project_iam_member" "service_account_monitoring_viewer" {
  project = var.project

  role   = "roles/monitoring.viewer"
  member = "serviceAccount:${google_service_account.this.email}"
}

resource "google_project_iam_member" "service_account_resource_metadata_writer" {
  project = var.project

  role   = "roles/stackdriver.resourceMetadata.writer"
  member = "serviceAccount:${google_service_account.this.email}"
}
