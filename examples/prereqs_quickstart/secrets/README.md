# EXAMPLE: Secrets Configuration on Consul

## About This Example

The Consul on GKE module requires the use of the
[GCP Secret Manager](https://cloud.google.com/secret-manager/docs/overview) service.

This module creates a secret manager that will be used to store the Consul federation secret version created in the Consul on GKE module.

## How to Use This Module

- Ensure your GCP credentials are [configured
   correctly](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#authentication)
- Enable the [Secret Manager API](https://cloud.google.com/secret-manager/docs/reference/rest)

- Run `terraform init` and `terraform apply`

## Note

- Please note the following output produced by this Terraform as this
  information will be used as input for the Consul on GKE installation module:
   - `federation_secret_id`
