/**
 * Copyright © 2014-2022 HashiCorp, Inc.
 *
 * This Source Code is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this project, you can obtain one at http://mozilla.org/MPL/2.0/.
 *
 */

variable "project_id" {
  type        = string
  description = "The project ID to host the network in"
}

variable "network_name" {
  type        = string
  default     = "consul-test-network"
  description = "The name of the VPC network being created"
}

variable "region" {
  type        = string
  description = "GCP region in which to launch resources"
}
