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

module "app" {
  source = "../../examples/apps"

  cluster_name = var.cluster_name
  project_id   = var.project_id
  region       = var.region
}
