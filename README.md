# Consul Enterprise on GKE Module

This is a Terraform module for provisioning two
[federated](https://www.consul.io/docs/k8s/installation/multi-cluster) Consul
Enterprise clusters on [GKE](https://cloud.google.com/kubernetes-engine) using Consul version
1.11.15+.

## How to Use This Module

- Ensure your GCP credentials are [configured
  correctly](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#authentication)
  and have permission to use the following GCP services:
    - [Kubernetes Engine API](https://cloud.google.com/kubernetes-engine/docs/reference/rest)
    - [Secret Manager API](https://cloud.google.com/secret-manager/docs/reference/rest)

- Install [kubectl](https://kubernetes.io/docs/reference/kubectl/) (this will be
  used to verify Consul cluster federation status).
  - To update the [kubeconfig context](https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl) with your current cluster,
  run:
  ```shell
  $ gcloud container clusters get-credentials CLUSTER_NAME
  ```

- This module assumes you have an existing VPC and two existing GKE clusters, as well as a GCP secrets manager available for storing Consul federation secrets. If
  you do not, you may use the following
  [quickstart](https://github.com/hashicorp/terraform-gcp-consul-ent-k8s/tree/main/examples/prereqs_quickstart)
  to deploy these resources.

- If you would like deploy this module into existing GKE clusters, please make sure a firewall rule is in place to [allow the GKE master to hit non 443 ports](https://cloud.google.com/kubernetes-engine/docs/how-to/private-clusters#add_firewall_rules) for Webhooks/Admission Controllers.

- You will create two files named `main.tf` and place them each in a different
  directory.

- Your first `main.tf` should look like this (note that `primary_datacenter` is
  set to `true`). This will install your primary Consul cluster.

```hcl
provider "google" {
  project = "<your GCP project id>"
  region     = "<your GCP region>"
}

module "primary_consul_cluster" {
  source  = "hashicorp/consul-ent-k8s/gcp"
  version = "0.1.0"

  consul_license       = file("<path to Consul Enterprise license")
  cluster_location     = "<region location of your Kubernetes cluster>"
  cluster_name         = "<name of your first GKE cluster>"
  federation_secret_id = "<secret id/name given to the google secrets manager secret for the Consul federation secret with the format projects/{{project}}/secrets/{{secret_id}}>"
  primary_datacenter   = true
}
```

- Your second `main.tf` should look like this (note that `primary_datacenter` is
  set to `false`). This will install your secondary Consul cluster.

```hcl
provider "google" {
  project = "<your GCP project id>"
  region     = "<your GCP region>"
}

module "secondary_consul_cluster" {
  source  = "hashicorp/consul-ent-k8s/gcp"
  version = "0.1.0"

  consul_license       = file("<path to Consul Enterprise license")
  cluster_location     = "<region location of your Kubernetes cluster>"
  cluster_name         = "<name of your second GKE cluster>"
  federation_secret_id = "<secret id/name given to the google secrets manager secret for the Consul federation secret with the format projects/{{project}}/secrets/{{secret_id}}>"
  primary_datacenter   = false
}

```

- Run `terraform init` and `terraform apply` first in the directory that
  contains the `main.tf` file that will set up your primary Consul cluster. Once
  that apply is complete, run the same commands in the directory containing the
  `main.tf` file that will set up your secondary Consul cluster. Once this is
  complete, you should have two federated Consul clusters.

To verify that both datacenters are federated, run the consul members -wan
command on one of the Consul server pods:

```shell
$ kubectl exec statefulset/consul-server --namespace=consul -- consul members -wan
```

Your output should show servers from both `dc1` and `dc2` similar to what is
show below:

```shell
Node                 Address           Status  Type    Build       Protocol  DC   Partition  Segment
consul-server-0.dc1  10.0.7.15:8302    alive   server  1.11.5+ent  2         dc1  default    <all>
consul-server-0.dc2  10.0.41.80:8302   alive   server  1.11.5+ent  2         dc2  default    <all>
consul-server-1.dc1  10.0.77.40:8302   alive   server  1.11.5+ent  2         dc1  default    <all>
consul-server-1.dc2  10.0.27.88:8302   alive   server  1.11.5+ent  2         dc2  default    <all>
consul-server-2.dc1  10.0.40.168:8302  alive   server  1.11.5+ent  2         dc1  default    <all>
consul-server-2.dc2  10.0.77.252:8302  alive   server  1.11.5+ent  2         dc2  default    <all>
consul-server-3.dc1  10.0.4.180:8302   alive   server  1.11.5+ent  2         dc1  default    <all>
consul-server-3.dc2  10.0.28.185:8302  alive   server  1.11.5+ent  2         dc2  default    <all>
consul-server-4.dc1  10.0.91.5:8302    alive   server  1.11.5+ent  2         dc1  default    <all>
consul-server-4.dc2  10.0.59.144:8302  alive   server  1.11.5+ent  2         dc2  default    <all>
```

You can also use the consul catalog services command with the -datacenter flag
to ensure each datacenter can read each other's services. In this example, the
kubectl context is `dc1` and is querying for the list of services in `dc2`:

```shell
$ kubectl exec statefulset/consul-server --namespace=consul -- consul catalog services -datacenter dc2
```

Your output should show the following:

```shell
consul
mesh-gateway
```

## Deploying Example Applications

To deploy and configure some example applications, please see the
[apps](https://github.com/hashicorp/terraform-gcp-consul-ent-k8s/tree/main/examples/apps)
directory.

**NOTE: when running `terraform destroy` on this module to uninstall Consul,
please run `terraform destroy` on your secondary Consul cluster and wait for it
to complete before destroying your primary Consul cluster.**

## License

This code is released under the Mozilla Public License 2.0. Please see
[LICENSE](https://github.com/hashicorp/terraform-gcp-consul-ent-k8s/blob/main/LICENSE)
for more details.
