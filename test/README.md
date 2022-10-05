## Overview

This test directory defines basic integration tests for the module.

## Prereqs

* Terraform or tfenv in PATH
* [Terraform Cloud credentials](https://www.terraform.io/cli/commands/login)
* [gcloud CLI](https://cloud.google.com/sdk/docs/install) installed and logged in (see below)
* Consul Enterprise license in place, via either:
  * A `consul.hclic` file in this directory (it's gitignored so you can't accidentally commit it), or
  * The `TEST_CONSUL_ENT_LICENSE` environment variable

### Login

Configure credentials (substituting the doormat project ID):
```
# Terraform use
gcloud auth application-default login
gcloud auth application-default set-quota-project <PROJECTID>

# gcloud CLI use (not needed for test execution but for used for enabling services below)
gcloud auth login
gcloud config set project <PROJECT_ID>
```

### Account APIs

Enable account APIs:
```
gcloud services enable secretmanager.googleapis.com
gcloud services enable container.googleapis.com
```

## Use

```
go test -v -timeout 120m
```

Optional environment variables:
  * `DEPLOY_ENV` - set this to change the prefix applied to resource names.
  * `CLOUDSDK_COMPUTE_REGION` - set the region in which resources are deployed
  * `TEST_CONSUL_ENT_LICENSE` - See Prereqs above about options for providing the Consul Enterprise license
  * `TEST_DONT_DESTROY_UPON_SUCCESS` - set this to skip running terraform destroy upon testing success

The `go test` will populate terraform `.auto.tfvars` in each module directory and execute `terraform apply` sequentially through them. If all deploys & tests pass, each module will be destroyed in reverse order.

### Cleaning Up

If resources aren't deleted automatically (at the end of successful tests), Terraform can be manually invoked to delete them. See the `destroy.sh` script for an example of doing this.
