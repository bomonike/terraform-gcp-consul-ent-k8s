/**
 * Copyright © 2014-2022 HashiCorp, Inc.
 *
 * This Source Code is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this project, you can obtain one at http://mozilla.org/MPL/2.0/.
 *
 */

terraform {
  cloud {
    organization = "hc-tfc-dev"

    workspaces {
      tags = [
        "integrationtest",
      ]
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "quickstart" {
  source = "../../examples/prereqs_quickstart"

  network_name       = "${var.resource_name_prefix}-consul"
  project_id         = var.project_id
  region             = var.region
  gke_1_cluster_name = "${var.resource_name_prefix}-consul-primary"
  gke_2_cluster_name = "${var.resource_name_prefix}-consul-secondary"
}
output "primary_cluster_name" {
  value = module.quickstart.gke_1_cluster_name
}
output "secondary_cluster_name" {
  value = module.quickstart.gke_2_cluster_name
}
output "federation_secret_id" {
  value = module.quickstart.federation_secret_id
}
