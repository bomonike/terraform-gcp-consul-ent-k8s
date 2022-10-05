/**
 * Copyright © 2014-2022 HashiCorp, Inc.
 *
 * This Source Code is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this project, you can obtain one at http://mozilla.org/MPL/2.0/.
 *
 */

variable "chart_name" {
  type        = string
  description = "Chart name to be installed"
}

variable "chart_repository" {
  type        = string
  description = "Repository URL where to locate the requested chart"
}

variable "create_namespace" {
  type        = bool
  description = "Create the namespace if it does not yet exist"
}

variable "consul_helm_chart_version" {
  type        = string
  description = "Version of Consul helm chart."
}

variable "consul_license" {
  type        = string
  description = "Consul license"
}

variable "consul_version" {
  type        = string
  description = "Version of Consul Enterprise to install"
}

variable "federation_secret_id" {
  type        = string
  description = "Secret id/name given to the google secrets manager secret for the Consul federation secret"
}

variable "kubernetes_namespace" {
  type        = string
  description = "The namespace to install the release into"
}

variable "primary_datacenter" {
  type        = bool
  description = "If true, installs Consul with a primary datacenter configuration. Set to false for secondary datacenters"
}

variable "release_name" {
  type        = string
  description = "The helm release name"
}

variable "server_replicas" {
  type        = number
  description = "The number of Consul server replicas"
}
