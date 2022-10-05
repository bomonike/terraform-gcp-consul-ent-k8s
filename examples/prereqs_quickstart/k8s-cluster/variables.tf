/**
 * Copyright © 2014-2022 HashiCorp, Inc.
 *
 * This Source Code is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this project, you can obtain one at http://mozilla.org/MPL/2.0/.
 *
 */

variable "add_master_webhook_firewall_rules" {
  type        = bool
  default     = true
  description = "Create master_webhook firewall rules for ports defined in `firewall_inbound_ports`"
}

variable "cluster_name" {
  type        = string
  description = "The name to give the new Kubernetes cluster"
}

variable "disk_size_consul_np" {
  type        = number
  default     = 512
  description = "Size of the disk attached to each node, specified in GB"
}

variable "disk_type_consul_np" {
  type        = string
  default     = "pd-balanced"
  description = "Type of the disk attached to each node"
}

variable "firewall_priority" {
  type        = number
  default     = 1000
  description = "Priority rule for firewall rules"
}

variable "gke_num_nodes" {
  type        = number
  default     = 2
  description = "Number of gke nodes per zone"
}

variable "machine_type" {
  type        = string
  default     = "n2-standard-2"
  description = "K8s machine type"
}

variable "master_ipv4_cidr_block" {
  type        = string
  description = "The IP range in CIDR notation to use for the hosted master network, e.g. 172.16.0.0/28"
}

variable "network" {
  type        = string
  description = "Network name"
}

variable "oauth_scopes_consul" {
  type        = list(string)
  default     = ["https://www.googleapis.com/auth/cloud-platform"]
  description = "The set of Google API scopes to be made available on all of the node VMs under the default service account for the consul node pool"
}

variable "oauth_scopes_default" {
  type        = list(string)
  default     = ["https://www.googleapis.com/auth/cloud-platform"]
  description = "The set of Google API scopes to be made available on all of the node VMs under the default service account for the default node pool"
}

variable "pods_range_name" {
  type        = string
  default     = "pods-range"
  description = "Name of subnet secondary range for pods"
}

variable "project_id" {
  type        = string
  description = "The project ID to host the network in"
}

variable "region" {
  type        = string
  description = "GCP region in which to launch resources"
}

variable "services_range_name" {
  type        = string
  default     = "services-range"
  description = "Name of subnet secondary range for services"
}

variable "subnetwork" {
  type        = string
  description = "Subnetwork self-link, e.g. https://www.googleapis.com/compute/v1/projects/{project_id}/regions/{region}/subnetworks/{subnet_name}"
}

variable "node_tags" {
  type        = list(string)
  default     = ["gke-node"]
  description = "Node tags"
}
