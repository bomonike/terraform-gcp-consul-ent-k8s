/**
 * Copyright © 2014-2022 HashiCorp, Inc.
 *
 * This Source Code is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this project, you can obtain one at http://mozilla.org/MPL/2.0/.
 *
 */

terraform {
  required_version = ">= 1.2.1"

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 4.41"
    }
    google-beta = {
      source = "hashicorp/google-beta"
      version = "~> 4.41"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.14"
    }
    helm = {
      source = "hashicorp/helm"
      version = "~> 2.7"
    }
  }
}
