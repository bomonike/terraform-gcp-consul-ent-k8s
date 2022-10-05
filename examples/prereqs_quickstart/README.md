# Example Prerequisite Configuration for Consul on Kubernetes Module

This is a quickstart example module for creating prerequisite resources for installing Consul on Kubernetes
compatible with reference architecture guidelines.

Module resources include:

- GCP VPC with two subnetworks

- GCP secrets manager

- Two private regional K8s clusters


## How to Use This Module
- Ensure your GCP credentials are [configured
  correctly](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#authentication)
  , have permission to use the following GCP services, and that these APIs are [enabled](https://cloud.google.com/endpoints/docs/openapi/enable-api)
   within your GCP project:
    - [Kubernetes Engine API](https://cloud.google.com/kubernetes-engine/docs/reference/rest)
    - [Secret Manager API](https://cloud.google.com/secret-manager/docs/reference/rest)


- Configure the required variables:

* `gke_1_cluster_name` - The name to give the primary Consul Kubernetes cluster
* `gke_2_cluster_name` - The name to give the secondary Consul Kubernetes cluster
* `project_id` - The project ID of the GCP project to host resources
* `region` - GCP region in which to launch resources


- From the prereqs_quickstart directory, run `terraform init` and `terraform apply`

# A note on using kubectl

If you want to run `kubectl` commands against your cluster, be sure to update
your kubeconfig as shown for each cluster:

```shell
$ gcloud container clusters get-credentials CLUSTER_NAME
```

This command will also update the kubectl
[context](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/#context).

# Note:

- If you have used the main module to install the Consul helm chart, please be sure to run `terraform destroy` from there to uninstall the helm chart BEFORE destroying these prerequisite resources. Failure to uninstall Consul from the main module may result in a failed `terraform destroy` and lingering resources in your VPC.
