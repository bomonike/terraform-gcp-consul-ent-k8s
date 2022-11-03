variable "autoscaling" {
  default = []
  type    = list(any)
}

variable "auto_upgrade" {
  default = true
  type    = bool
}
variable "auto_repair" {
  default = true
  type    = bool
}

variable "cluster" {
  type = string
}

variable "disk_size_gb" {
  default = 50
  type    = number
}

variable "disk_type" {
  default = "pd-standard"
  type    = string
}

variable "enable_integrity_monitoring" {
  default = true
  type    = bool
}

variable "enable_secure_boot" {
  default = true
  type    = bool
}

variable "image_type" {
  default = "COS_CONTAINERD"
  type    = string
}

variable "kubelet_config" {
  default = []
  type    = list(any)
}

variable "kubernetes_version" {
  type = string
}

variable "linux_node_config" {
  default = []
  type    = list(any)
}

variable "labels" {
  default = ({})
  type    = map(string)
}

variable "location" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "max_pods_per_node" {
  default = 110
  type    = number
}

variable "metadata" {
  default = ({})
  type    = map(string)
}

variable "name" {
  type = string
}

variable "node_count" {
  default = 1
  type    = number
}

variable "node_locations" {
  default = []
  type    = list(string)
}

variable "oauth_scopes" {
  default = [
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring",
    "https://www.googleapis.com/auth/monitoring.write",
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/compute"
  ]

  type = list(string)
}

variable "preemptible" {
  default = false
  type    = bool
}

variable "project" {
  type = string
}

variable "sandbox_config" {
  default = []
  type    = list(any)
}

variable "sa_node_name" {
  default = "gke-node-pool-sa"
  type    = string
}

variable "spot" {
  default = false
  type    = bool
}

variable "tags" {
  default = []
  type    = list(string)
}

variable "workload_metadata_mode" {
  default = "GKE_METADATA"
  type    = string
}

variable "upgrade_settings" {
  default = []
  type    = list(any)
}
