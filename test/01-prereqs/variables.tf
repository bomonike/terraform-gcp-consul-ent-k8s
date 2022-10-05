/**
 * Copyright © 2014-2022 HashiCorp, Inc.
 *
 * This Source Code is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this project, you can obtain one at http://mozilla.org/MPL/2.0/.
 *
 */

variable "project_id" { type = string }
variable "resource_name_prefix" { type = string }

variable "region" {
  type        = string
  default     = "us-west1"
  description = "Region in which to launch resources"
}
