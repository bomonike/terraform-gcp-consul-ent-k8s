/**
 * Copyright © 2014-2022 HashiCorp, Inc.
 *
 * This Source Code is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this project, you can obtain one at http://mozilla.org/MPL/2.0/.
 *
 */

data "google_client_config" "default" {
}

data "google_container_cluster" "default" {
  name     = var.cluster_name
  location = var.cluster_location
}

provider "helm" {
  kubernetes {
    host  = "https://${data.google_container_cluster.default.endpoint}"
    token = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(
      data.google_container_cluster.default.master_auth[0].cluster_ca_certificate,
    )
  }
}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.default.endpoint}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.default.master_auth[0].cluster_ca_certificate,
  )
}

provider "kubectl" {
  host  = "https://${data.google_container_cluster.default.endpoint}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.default.master_auth[0].cluster_ca_certificate,
  )
  load_config_file = false
}

resource "kubernetes_namespace" "consul" {
  metadata {
    name = var.kubernetes_namespace
  }
}

module "helm_install" {
  source = "./modules/helm_install"

  chart_name                = var.chart_name
  chart_repository          = var.chart_repository
  consul_helm_chart_version = var.consul_helm_chart_version
  consul_license            = var.consul_license
  kubernetes_namespace      = var.kubernetes_namespace
  consul_version            = var.consul_version
  create_namespace          = var.create_namespace
  federation_secret_id      = var.federation_secret_id
  primary_datacenter        = var.primary_datacenter
  release_name              = var.release_name
  server_replicas           = var.server_replicas

  depends_on = [
    kubernetes_namespace.consul
  ]
}
