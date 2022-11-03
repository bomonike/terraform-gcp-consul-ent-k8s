resource "google_container_node_pool" "this" {
  provider = google-beta

  cluster           = var.cluster
  location          = var.location
  max_pods_per_node = var.max_pods_per_node
  node_locations    = var.node_locations
  name              = var.name
  node_count        = var.node_count
  version           = var.kubernetes_version

  management {
    auto_repair  = var.auto_repair
    auto_upgrade = var.auto_upgrade
  }

  node_config {
    #tfsec:ignore:GCP012
    disk_size_gb = var.disk_size_gb
    disk_type    = var.disk_type

    image_type = var.image_type

    machine_type = var.machine_type
    preemptible  = var.preemptible
    spot         = var.spot

    oauth_scopes    = var.oauth_scopes
    service_account = google_service_account.this.email

    metadata = var.metadata
    labels   = var.labels
    tags     = var.tags

    workload_metadata_config {
      mode = var.workload_metadata_mode
    }

    dynamic "kubelet_config" {
      for_each = var.kubelet_config

      content {
        cpu_manager_policy   = kubelet_config.value.cpu_manager_policy
        cpu_cfs_quota        = lookup(kubelet_config.value, "cpu_cfs_quota", "")
        cpu_cfs_quota_period = lookup(kubelet_config.value, "cpu_cfs_quota_period", "")
      }
    }

    dynamic "linux_node_config" {
      for_each = var.linux_node_config

      content {
        sysctls = linux_node_config.value.sysctls
      }
    }

    dynamic "sandbox_config" {
      for_each = var.sandbox_config

      content {
        sandbox_type = sandbox_config.value.sandbox_type
      }
    }

    shielded_instance_config {
      enable_secure_boot          = var.enable_secure_boot
      enable_integrity_monitoring = var.enable_integrity_monitoring
    }
  }

  dynamic "autoscaling" {
    for_each = var.autoscaling

    content {
      min_node_count = autoscaling.value.min_node_count
      max_node_count = autoscaling.value.max_node_count
    }
  }

  dynamic "upgrade_settings" {
    for_each = var.upgrade_settings

    content {
      max_surge       = upgrade_settings.value.max_surge
      max_unavailable = upgrade_settings.value.max_unavailable
    }
  }

  lifecycle {
    ignore_changes = [node_count]
  }
}
