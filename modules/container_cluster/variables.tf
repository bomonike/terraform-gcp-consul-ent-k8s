variable "authenticator_groups_config" {
  default = ""
  type    = string
}

variable "binary_authorization_evaluation_mode" {
  default = "DISABLED"
  type    = string
}

variable "cluster_autoscaling" {
  default = []
  type    = list(any)
}

variable "cloudrun_config_disabled" {
  default = true
  type    = bool
}

variable "cluster_cidr_range" {
  type = string
}

variable "cluster_telemetry_type" {
  default = "SYSTEM_ONLY"
  type    = string
}

variable "config_connector_config_enabled" {
  default = true
  type    = bool
}

variable "description" {
  default = null
  type    = string
}

variable "default_max_pods_per_node" {
  default = null
  type    = string
}

variable "dns_cache_config_enabled" {
  default = true
  type    = bool
}

variable "enable_binary_authorization" {
  default = true
  type    = bool
}

variable "enable_intranode_visibility" {
  default = false
  type    = bool
}

variable "enable_private_endpoint" {
  default = false
  type    = bool
}

variable "enable_private_nodes" {
  default = true
  type    = bool
}

variable "enable_tpu" {
  default = false
  type    = bool
}

variable "enable_shielded_nodes" {
  default = true
  type    = bool
}

variable "gke_backup_agent_config_enabled" {
  default = false
  type    = bool
}

variable "gce_persistent_disk_csi_driver_config_enabled" {
  default = false
  type    = bool
}

variable "horizontal_pod_autoscaling_disabled" {
  default = false
  type    = bool
}

variable "http_load_balancing_disabled" {
  default = false
  type    = bool
}

variable "issue_client_certificate" {
  default = false
  type    = bool
}

variable "istio_config_disabled" {
  default = true
  type    = bool
}

variable "identity_service_config_enabled" {
  default = false
  type    = bool
}

variable "kalm_config_enabled" {
  default = false
  type    = bool
}

variable "kms_location" {
  default = "europe"
  type    = string
}

variable "kms_key_ring_enabled" {
  default = false
  type    = bool
}

variable "location" {
  type = string
}

variable "maintenance_policy" {
  default = {}
  type    = map(any)
}

variable "min_master_version" {
  type = string
}

variable "master_ipv4_cidr_range" {
  type = string
}

variable "master_authorized_networks_config" {
  default = []
  type    = list(any)
}

variable "name" {
  type = string
}

variable "network" {
  type = string
}

variable "networking_mode" {
  default = "VPC_NATIVE"
  type    = string
}

variable "node_locations" {
  default = null
  type    = list(string)
}

variable "network_policy_config_disabled" {
  default = false
  type    = bool
}

variable "pods_cidr_range" {
  type = string
}

variable "pod_security_policy_config_enabled" {
  default = false
  type    = bool
}

variable "release_channel" {
  default = "UNSPECIFIED"
  type    = string
}

variable "remove_default_node_pool" {
  default = true
  type    = bool
}

variable "resource_labels" {
  default = {}
  type    = map(string)
}

variable "services_cidr_range" {
  type = string
}

variable "subnetwork_log_config" {
  default = []
  type    = list(any)
}
