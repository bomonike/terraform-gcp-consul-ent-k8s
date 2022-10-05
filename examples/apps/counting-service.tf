/**
 * Copyright © 2014-2022 HashiCorp, Inc.
 *
 * This Source Code is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this project, you can obtain one at http://mozilla.org/MPL/2.0/.
 *
 */

resource "kubernetes_manifest" "service_consul_counting" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Service"
    "metadata" = {
      "name"      = "counting"
      "namespace" = var.kubernetes_namespace
    }
    "spec" = {
      "ports" = [
        {
          "name"       = "http"
          "port"       = 9001
          "protocol"   = "TCP"
          "targetPort" = 9001
        },
      ]
      "selector" = {
        "app" = "counting"
      }
    }
  }
}

resource "kubernetes_manifest" "serviceaccount_consul_counting" {
  manifest = {
    "apiVersion"                   = "v1"
    "automountServiceAccountToken" = true
    "kind"                         = "ServiceAccount"
    "metadata" = {
      "name"      = "counting"
      "namespace" = var.kubernetes_namespace
    }
  }
}

resource "kubernetes_manifest" "servicedefaults_consul_counting" {
  manifest = {
    "apiVersion" = "consul.hashicorp.com/v1alpha1"
    "kind"       = "ServiceDefaults"
    "metadata" = {
      "name"      = "counting"
      "namespace" = var.kubernetes_namespace
    }
    "spec" = {
      "protocol" = "http"
    }
  }
}

resource "kubernetes_manifest" "deployment_consul_counting" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind"       = "Deployment"
    "metadata" = {
      "name"      = "counting"
      "namespace" = var.kubernetes_namespace
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app"     = "counting"
          "service" = "counting"
        }
      }
      "template" = {
        "metadata" = {
          "annotations" = {
            "consul.hashicorp.com/connect-inject"            = "true"
            "consul.hashicorp.com/connect-service-upstreams" = "dashboard:9002"
          }
          "labels" = {
            "app"     = "counting"
            "service" = "counting"
          }
        }
        "spec" = {
          "containers" = [
            {
              "image" = "hashicorp/counting-service:0.0.2"
              "name"  = "counting"
              "ports" = [
                {
                  "containerPort" = 9001
                },
              ]
            },
          ]
          "serviceAccountName" = "counting"
        }
      }
    }
  }
}
