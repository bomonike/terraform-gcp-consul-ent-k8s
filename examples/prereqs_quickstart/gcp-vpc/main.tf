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

module "test_vpc_module" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 3.2.0"
  project_id   = var.project_id
  network_name = var.network_name

  subnets = [
    {
      subnet_name           = "subnet-01"
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = var.region
      subnet_private_access = true
    },
    {
      subnet_name           = "subnet-02"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = var.region
      subnet_private_access = true
    }
  ]

  secondary_ranges = {
    subnet-01 = [
      {
        ip_cidr_range = "10.36.0.0/14"
        range_name    = "pods-range"
      },
      {
        ip_cidr_range = "10.40.0.0/20"
        range_name    = "services-range"
      },
    ]

    subnet-02 = [
      {
        ip_cidr_range = "10.144.0.0/14"
        range_name    = "pods-range"
      },
      {
        ip_cidr_range = "10.148.0.0/20"
        range_name    = "services-range"
      },
    ]
  }
}

#NAT router
resource "google_compute_router" "consul_router" {
  name    = "consul-router"
  project = var.project_id
  region  = var.region
  network = module.test_vpc_module.network_name
}

# NAT service
resource "google_compute_router_nat" "consul_nat" {
  name    = "consul-nat-1"
  project = var.project_id
  router  = google_compute_router.consul_router.name
  region  = var.region

  nat_ip_allocate_option = "AUTO_ONLY"

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
