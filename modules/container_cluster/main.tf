data "google_project" "this" {}

resource "google_container_cluster" "this" { #tfsec:ignore:GCP009
  #checkov:skip=CKV_GCP_24:Configurable block
  #checkov:skip=CKV_GCP_21:Configurable block
  #checkov:skip=CKV_GCP_1:External logging
  #checkov:skip=CKV_GCP_8:External monitoring
  #checkov:skip=CKV_GCP_13:Basic auth disabled
  provider = google-beta

  name                        = var.name
  location                    = var.location
  node_locations              = var.node_locations
  description                 = var.description
  default_max_pods_per_node   = var.default_max_pods_per_node
  enable_intranode_visibility = var.enable_intranode_visibility
  enable_tpu                  = var.enable_tpu
  enable_shielded_nodes       = var.enable_shielded_nodes
  initial_node_count          = 1
  networking_mode             = var.networking_mode
  min_master_version          = var.min_master_version
  network                     = var.network
  remove_default_node_pool    = var.remove_default_node_pool
  resource_labels             = var.resource_labels
  subnetwork                  = google_compute_subnetwork.this.self_link

  addons_config {
    cloudrun_config {
      disabled = var.cloudrun_config_disabled
    }

    config_connector_config {
      enabled = var.config_connector_config_enabled
    }

    dns_cache_config {
      enabled = var.dns_cache_config_enabled
    }

    gce_persistent_disk_csi_driver_config {
      enabled = var.gce_persistent_disk_csi_driver_config_enabled
    }

    gke_backup_agent_config {
      enabled = var.gke_backup_agent_config_enabled
    }

    horizontal_pod_autoscaling {
      disabled = var.horizontal_pod_autoscaling_disabled
    }

    http_load_balancing {
      disabled = var.http_load_balancing_disabled
    }

    istio_config {
      disabled = var.istio_config_disabled
    }

    kalm_config {
      enabled = var.kalm_config_enabled
    }

    network_policy_config {
      disabled = var.network_policy_config_disabled
    }
  }

  binary_authorization {
    evaluation_mode = var.binary_authorization_evaluation_mode
  }

  cluster_telemetry {
    type = var.cluster_telemetry_type
  }

  database_encryption {
    state    = var.kms_key_ring_enabled ? "ENCRYPTED" : "DECRYPTED"
    key_name = var.kms_key_ring_enabled ? google_kms_crypto_key.this[0].name : ""
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = google_compute_subnetwork.this.secondary_ip_range[0].range_name
    services_secondary_range_name = google_compute_subnetwork.this.secondary_ip_range[1].range_name
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = var.issue_client_certificate
    }
  }

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = var.master_authorized_networks_config

      content {
        cidr_block   = cidr_blocks.value.cidr_range
        display_name = cidr_blocks.value.display_name
      }
    }
  }

  network_policy {
    enabled = true
  }

  pod_security_policy_config {
    #tfsec:ignore:google-gke-enforce-pod-security-policy
    #tfsec:ignore:GCP009
    enabled = var.pod_security_policy_config_enabled
  }

  private_cluster_config {
    enable_private_endpoint = var.enable_private_endpoint
    enable_private_nodes    = var.enable_private_nodes
    master_ipv4_cidr_block  = var.master_ipv4_cidr_range
  }

  release_channel {
    channel = var.release_channel
  }

  workload_identity_config {
    workload_pool = "${data.google_project.this.project_id}.svc.id.goog"
  }

  dynamic "cluster_autoscaling" {
    for_each = var.cluster_autoscaling

    content {
      enabled             = cluster_autoscaling.value.enabled
      autoscaling_profile = cluster_autoscaling.value.autoscaling_profile

      dynamic "resource_limits" {
        for_each = cluster_autoscaling.value.resource_limits

        content {
          resource_type = resource_limits.value.resource_type
          minimum       = resource_limits.value.minimum
          maximum       = resource_limits.value.maximum
        }
      }

      dynamic "auto_provisioning_defaults" {
        for_each = cluster_autoscaling.value.auto_provisioning_defaults

        content {
          min_cpu_platform = auto_provisioning_defaults.value.min_cpu_platform
          oauth_scopes     = auto_provisioning_defaults.value.oauth_scopes
          service_account  = auto_provisioning_defaults.value.service_account
        }
      }
    }
  }

  dynamic "maintenance_policy" {
    for_each = var.maintenance_policy

    content {
      recurring_window {
        start_time = maintenance_policy.value.start_time
        end_time   = maintenance_policy.value.end_time
        recurrence = maintenance_policy.value.recurrence
      }

      dynamic "maintenance_exclusion" {
        for_each = maintenance_policy.value.maintenance_exclusion

        content {
          exclusion_name = maintenance_exclusion.value.exclusion_name
          start_time     = maintenance_exclusion.value.start_time
          end_time       = maintenance_exclusion.value.end_time

          exclusion_options {
            scope = maintenance_exclusion.value.scope
          }
        }
      }
    }
  }
}
