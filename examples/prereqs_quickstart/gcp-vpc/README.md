# EXAMPLE: Create a Prerequisite VPC Network

## About This Example

In order to deploy the Consul on Kubernetes module, a preconfigured VPC network must first be deployed. This example points to an existing module that can be configured to deploy a Consul on K8s ready VPC.
Module documentation can be found [here](https://registry.terraform.io/modules/terraform-google-modules/network/google/latest).

## Network Design for Consul Enterprise
The prerequisite VPC Network for Consul on K8s should contain the following:

- Cloud Router and Cloud NAT: necessary for downloading Consul

- Google Compute Network: manages a VPC network

- Subnets: two subnets in which to deploy the K8s cluster

## How to Use This Module

- Ensure GCP credentials are in [place](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#authentication) (e.g. `gcloud auth application-default login` on your workstation).

- Enable the following APIs in the Cloud Console:

  - [Compute Engine API](https://cloud.google.com/compute/docs/reference/rest/v1)

  - [Cloud Resource Manager API](https://cloud.google.com/resource-manager/reference/rest)

- Configure required (and optional if desired) variables

- Run `terraform init` and `terraform apply`

## Required inputs

### For the module:

* `project_id` - ID of the project in GCP
* `region` - GCP region in which to launch resources
