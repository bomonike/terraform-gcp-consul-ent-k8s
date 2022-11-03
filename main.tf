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
}
