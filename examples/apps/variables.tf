/**
 * Copyright © 2014-2022 HashiCorp, Inc.
 *
 * This Source Code is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this project, you can obtain one at http://mozilla.org/MPL/2.0/.
 *
 */

variable "cluster_name" {
  type        = string
  description = "Kubernetes cluster name on which to install Consul"
}

variable "kubernetes_namespace" {
  type        = string
  default     = "consul"
  description = "The namespace to install the release into"
}

variable "project_id" {
  type        = string
  description = "The project ID in which to build resources"
}

variable "region" {
  type        = string
  description = "GCP region in which to launch resources"
}
