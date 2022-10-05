/**
 * Copyright © 2014-2022 HashiCorp, Inc.
 *
 * This Source Code is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this project, you can obtain one at http://mozilla.org/MPL/2.0/.
 *
 */

variable "chart_name" {
  type        = string
  default     = "consul"
  description = "Chart name to be installed"
}

variable "chart_repository" {
  type        = string
  default     = "https://helm.releases.hashicorp.com"
  description = "Repository URL where to locate the requested chart"
}

variable "cluster_location" {
  type        = string
  description = "Kubernetes cluster region"
}

variable "cluster_name" {
  type        = string
  description = "Kubernetes cluster name on which to install Consul"
}

variable "consul_helm_chart_version" {
  type        = string
  description = "Version of Consul helm chart"
  # Changing this version may break the reliability
  # of Consul installation and federation
  default = "0.41.0"
}

variable "consul_license" {
  type        = string
  description = "Path to your Consul license file"
}

variable "consul_version" {
  type        = string
  description = "Version of Consul Enterprise to install"
  default     = "1.11.5"
}

variable "create_namespace" {
  type        = bool
  default     = true
  description = "Create the k8s namespace if it does not yet exist"
}

variable "federation_secret_id" {
  type        = string
  description = "Secret id/name given to the google secrets manager secret for the Consul federation secret"
}

variable "kubernetes_namespace" {
  type        = string
  default     = "consul"
  description = "The namespace to install the release into"
}

variable "primary_datacenter" {
  type        = bool
  description = "If true, installs Consul with a primary datacenter configuration. Set to false for secondary datacenters"
}

variable "release_name" {
  type        = string
  default     = "consul-release"
  description = "The helm release name"
}

variable "server_replicas" {
  type        = number
  default     = 5
  description = "The number of Consul server replicas"
}
