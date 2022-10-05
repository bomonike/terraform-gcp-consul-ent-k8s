# Google Kubernetes Engine Cluster Configuration
This is a Terraform module example for creating a Consul ready Kubernetes cluster on GKE.


## About This Module
This module creates a single [private regional K8s cluster](https://cloud.google.com/kubernetes-engine/docs/how-to/private-clusters) with a default node pool and a separately managed node pool.


A firewall rule is also included to [allow the GKE master to hit non 443 ports](https://cloud.google.com/kubernetes-engine/docs/how-to/private-clusters#add_firewall_rules) for Webhooks/Admission Controllers.


The default node pool configuration:
  - 1 node per zone, 3 nodes total
  - Cloud platform services access
  - Node taint to prevent noncritical pod scheduling


The separately managed node pool configuration:
  - 2 nodes per zone, 6 nodes total
  - Cloud platform services access
  - Consul specific recommended disk size/type and machine type

## How to Use This Module

- Ensure your GCP credentials are [configured
  correctly](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#authentication)
  and have permission to use the following GCP services:
    - [Kubernetes Engine API](https://cloud.google.com/kubernetes-engine/docs/reference/rest)


- To deploy without an existing VPC, use the [example VPC](https://github.com/hashicorp/terraform-gcp-consul-k8s/tree/main/examples/prereqs_quickstart/gcp-vpc)
  code to build out the prerequisite environment. Ensure you are selecting a
  region that has at least three [
  zones](https://cloud.google.com/compute/docs/regions-zones).


- To deploy into an existing VPC, ensure the following components exist and are
  routed to each other correctly:
  - Google Compute Network- manages a VPC network
  - Subnet- a single subnet in which to deploy the K8s cluster
  - One Cloud Router and [Cloud NAT](https://cloud.google.com/nat/docs/overview)


- Create a Terraform configuration that pulls in the k8s-cluster module and specifies
  values for the required variables:


```hcl
provider "google" {
  project = "my_project_id"
  region  = "us-west1"
}

module "gke-cluster-1" {
  source                 = "../k8s-cluster"
  cluster_name           = "my_gke1_cluster_name"
  master_ipv4_cidr_block = "172.16.0.0/28"
  network                = "my_network_name"
  project_id             = "my_project_id"
  region                 = "us-west1"
  subnetwork             = "https://www.googleapis.com/compute/v1/projects/my_project_id/regions/us-west1/subnetworks/subnet-01"
}
```


- Run `terraform init` and `terraform apply`
