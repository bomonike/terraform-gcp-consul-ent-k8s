resource "google_compute_subnetwork" "this" { #tfsec:ignore:google-compute-enable-vpc-flow-logs
  name                     = var.name
  network                  = var.network
  ip_cidr_range            = var.cluster_cidr_range
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "${var.name}-pods"
    ip_cidr_range = var.pods_cidr_range
  }

  secondary_ip_range {
    range_name    = "${var.name}-services"
    ip_cidr_range = var.services_cidr_range
  }

  dynamic "log_config" {
    for_each = var.subnetwork_log_config

    content {
      aggregation_interval = log_config.value.aggregation_interval
      flow_sampling        = log_config.value.flow_sampling
      metadata             = log_config.value.metadata
      metadata_fields      = lookup(log_config.value, "metadata_fields", null)
      filter_expr          = lookup(log_config.value, "filter_expr", null)
    }
  }
}
