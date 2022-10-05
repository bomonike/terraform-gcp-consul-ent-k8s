/**
 * Copyright © 2014-2022 HashiCorp, Inc.
 *
 * This Source Code is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this project, you can obtain one at http://mozilla.org/MPL/2.0/.
 *
 */

provider "google" {
  project = var.project_id
  region  = var.region
}
# GKE cluster
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  initial_node_count = 1

  network    = var.network
  subnetwork = var.subnetwork

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_range_name
    services_secondary_range_name = var.services_range_name
  }

  private_cluster_config {
    enable_private_endpoint = "false"
    enable_private_nodes    = "true"
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }

  node_config {
    taint {
      key    = "CriticalAddonsOnly"
      value  = "true"
      effect = "NO_SCHEDULE"
    }

    oauth_scopes = var.oauth_scopes_default
  }
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name     = "${google_container_cluster.primary.name}-np"
  location = var.region
  cluster  = google_container_cluster.primary.name

  node_count = var.gke_num_nodes

  node_config {

    disk_size_gb = var.disk_size_consul_np
    disk_type    = var.disk_type_consul_np

    labels = {
      cluster = var.cluster_name
    }

    machine_type = var.machine_type
    tags         = var.node_tags
    metadata = {
      disable-legacy-endpoints = "true"
    }
    oauth_scopes = var.oauth_scopes_consul
  }
}

/******************************************
  Allow GKE master to hit non 443 ports for
  Webhooks/Admission Controllers
  https://github.com/kubernetes/kubernetes/issues/79739
 *****************************************/
resource "google_compute_firewall" "master_webhooks" {
  count       = var.add_master_webhook_firewall_rules ? 1 : 0
  name        = "gke-${substr(var.cluster_name, 0, min(25, length(var.cluster_name)))}-webhooks"
  description = "Managed by terraform gke module: Allow master to hit pods for admission controllers/webhooks"
  project     = var.project_id
  network     = var.network
  priority    = var.firewall_priority
  direction   = "INGRESS"

  source_ranges = [var.master_ipv4_cidr_block]
  source_tags   = []
  target_tags   = var.node_tags

  allow {
    protocol = "tcp"
  }

  depends_on = [
    google_container_cluster.primary,
  ]

}
