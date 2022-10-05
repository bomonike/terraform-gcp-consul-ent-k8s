/**
 * Copyright © 2014-2022 HashiCorp, Inc.
 *
 * This Source Code is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this project, you can obtain one at http://mozilla.org/MPL/2.0/.
 *
 */

output "federation_secret_id" {
  value       = module.secret-manager.federation_secret_id
  description = "Secret id/name given to the Google Secret Manager secret for the Consul federation secret"
}

output "gke_1_cluster_name" {
  value       = module.gke-cluster-1.kubernetes_cluster_name
  description = "GKE Cluster Name"
}

output "gke_2_cluster_name" {
  value       = module.gke-cluster-2.kubernetes_cluster_name
  description = "GKE Cluster Name"
}
