/**
 * Copyright © 2014-2022 HashiCorp, Inc.
 *
 * This Source Code is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this project, you can obtain one at http://mozilla.org/MPL/2.0/.
 *
 */

resource "kubernetes_manifest" "service_consul_dashboard" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Service"
    "metadata" = {
      "name"      = "dashboard"
      "namespace" = var.kubernetes_namespace
    }
    "spec" = {
      "ports" = [
        {
          "name"       = "http"
          "port"       = 9002
          "protocol"   = "TCP"
          "targetPort" = 9002
        },
      ]
      "selector" = {
        "app" = "dashboard"
      }
    }
  }
}

resource "kubernetes_manifest" "serviceaccount_consul_dashboard" {
  manifest = {
    "apiVersion"                   = "v1"
    "automountServiceAccountToken" = true
    "kind"                         = "ServiceAccount"
    "metadata" = {
      "name"      = "dashboard"
      "namespace" = var.kubernetes_namespace
    }
  }
}

resource "kubernetes_manifest" "servicedefaults_consul_dashboard" {
  manifest = {
    "apiVersion" = "consul.hashicorp.com/v1alpha1"
    "kind"       = "ServiceDefaults"
    "metadata" = {
      "name"      = "dashboard"
      "namespace" = var.kubernetes_namespace
    }
    "spec" = {
      "protocol" = "http"
    }
  }
}

resource "kubernetes_manifest" "deployment_consul_dashboard" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind"       = "Deployment"
    "metadata" = {
      "name"      = "dashboard"
      "namespace" = var.kubernetes_namespace
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app"     = "dashboard"
          "service" = "dashboard"
        }
      }
      "template" = {
        "metadata" = {
          "annotations" = {
            "consul.hashicorp.com/connect-inject"            = "true"
            "consul.hashicorp.com/connect-service-upstreams" = "counting:9001"
          }
          "labels" = {
            "app"     = "dashboard"
            "service" = "dashboard"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name"  = "COUNTING_SERVICE_URL"
                  "value" = "http://localhost:9001"
                },
              ]
              "image" = "hashicorp/dashboard-service:0.0.4"
              "name"  = "dashboard"
              "ports" = [
                {
                  "containerPort" = 9002
                  "name"          = "http"
                },
              ]
            },
          ]
          "serviceAccountName" = "dashboard"
        }
      }
    }
  }
}
