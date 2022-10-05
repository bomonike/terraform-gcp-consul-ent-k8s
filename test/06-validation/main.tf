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

  required_providers {
    testingtoolsk8s = {
      source  = "app.terraform.io/hc-tfc-dev/testingtoolsk8s"
      version = "~> 0.1.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_client_config" "provider" {}

data "google_container_cluster" "cluster" {
  location = var.region
  name     = var.cluster_name
}

provider "testingtoolsk8s" {
  cluster_ca_certificate = base64decode(data.google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
  host                   = "https://${data.google_container_cluster.cluster.endpoint}"
  token                  = data.google_client_config.provider.access_token
}

resource "testingtoolsk8s_exec" "consul_wan_members" {
  namespace = "consul"
  pod       = "consul-server-4"

  command = [
    "consul",
    "members",
    "-wan",
  ]
}

output "consul_wan_members" {
  value = testingtoolsk8s_exec.consul_wan_members.stdout
}
