/**
 * Copyright © 2014-2022 HashiCorp, Inc.
 *
 * This Source Code is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this project, you can obtain one at http://mozilla.org/MPL/2.0/.
 *
 */

provider "google" {
  project = var.project_id
  region  = var.region
}

module "gcp-vpc" {
  source       = "./gcp-vpc/"
  network_name = var.network_name
  project_id   = var.project_id
  region       = var.region
}

module "gke-cluster-1" {
  source                 = "./k8s-cluster/"
  cluster_name           = var.gke_1_cluster_name
  master_ipv4_cidr_block = var.primary_master_ipv4_cidr_block
  network                = module.gcp-vpc.network_name
  project_id             = var.project_id
  region                 = var.region
  subnetwork             = module.gcp-vpc.subnetworks[0]
  pods_range_name        = module.gcp-vpc.subnets_secondary_ranges[0][0]["range_name"]
  services_range_name    = module.gcp-vpc.subnets_secondary_ranges[0][1]["range_name"]
}

module "gke-cluster-2" {
  source                 = "./k8s-cluster/"
  cluster_name           = var.gke_2_cluster_name
  master_ipv4_cidr_block = var.secondary_master_ipv4_cidr_block
  network                = module.gcp-vpc.network_name
  project_id             = var.project_id
  region                 = var.region
  subnetwork             = module.gcp-vpc.subnetworks[1]
  pods_range_name        = module.gcp-vpc.subnets_secondary_ranges[1][0]["range_name"]
  services_range_name    = module.gcp-vpc.subnets_secondary_ranges[1][1]["range_name"]
}

module "secret-manager" {
  source = "./secrets"
}
