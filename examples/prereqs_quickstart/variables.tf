/**
 * Copyright © 2014-2022 HashiCorp, Inc.
 *
 * This Source Code is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this project, you can obtain one at http://mozilla.org/MPL/2.0/.
 *
 */

variable "gke_1_cluster_name" {
  type        = string
  description = "The name to give the primary Consul Kubernetes cluster"
}

variable "gke_2_cluster_name" {
  type        = string
  description = "The name to give the secondary Consul Kubernetes cluster"
}

variable "network_name" {
  type        = string
  default     = "consul-test-network"
  description = "The name of the VPC network being created"
}

variable "primary_master_ipv4_cidr_block" {
  type        = string
  default     = "172.16.0.0/28"
  description = "The IP range in CIDR notation to use for the hosted master network, e.g. 172.16.0.0/28"
}

variable "project_id" {
  type        = string
  description = "The project ID to host the network in"
}

variable "region" {
  type        = string
  description = "GCP region in which to launch resources"
}

variable "secondary_master_ipv4_cidr_block" {
  type        = string
  default     = "172.16.0.16/28"
  description = "The IP range in CIDR notation to use for the hosted master network, e.g. 172.16.0.16/28"
}
