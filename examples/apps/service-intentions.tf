/**
 * Copyright © 2014-2022 HashiCorp, Inc.
 *
 * This Source Code is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this project, you can obtain one at http://mozilla.org/MPL/2.0/.
 *
 */

resource "kubernetes_manifest" "serviceintentions_consul_dashboard" {
  manifest = {
    "apiVersion" = "consul.hashicorp.com/v1alpha1"
    "kind"       = "ServiceIntentions"
    "metadata" = {
      "name"      = "dashboard"
      "namespace" = var.kubernetes_namespace
    }
    "spec" = {
      "destination" = {
        "name" = "counting"
      }
      "sources" = [
        {
          "name" = "dashboard"
          "permissions" = [
            {
              "action" = "allow"
              "http" = {
                "methods" = [
                  "GET",
                ]
                "pathPrefix" = "/"
              }
            },
          ]
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "serviceintentions_consul_counting" {
  manifest = {
    "apiVersion" = "consul.hashicorp.com/v1alpha1"
    "kind"       = "ServiceIntentions"
    "metadata" = {
      "name"      = "counting"
      "namespace" = var.kubernetes_namespace
    }
    "spec" = {
      "destination" = {
        "name" = "dashboard"
      }
      "sources" = [
        {
          "name" = "counting"
          "permissions" = [
            {
              "action" = "allow"
              "http" = {
                "methods" = [
                  "GET",
                ]
                "pathPrefix" = "/"
              }
            },
          ]
        },
      ]
    }
  }
}
