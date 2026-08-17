variable "web_service_url" {
  description = "Commvault CommServe API URL (e.g. https://myserver.example.com/commandcenter/api)"
  type        = string
}

variable "user_name" {
  description = "Commvault admin username"
  type        = string
}

variable "password" {
  description = "Commvault admin password"
  type        = string
  sensitive   = true
}

variable "cluster_name" {
  description = "Display name for the Kubernetes cluster in CommCell"
  type        = string
  default     = "Terraform-K8s-Cluster"
}

variable "api_server_endpoint" {
  description = "Kubernetes API server URL (e.g. https://k8s-api.example.com:6443)"
  type        = string
}

variable "service_account_name" {
  description = "Kubernetes service account used by CommVault to access the cluster"
  type        = string
  default     = "commvault-sa"
}

variable "service_token" {
  description = "Bearer token for the Kubernetes service account"
  type        = string
  sensitive   = true
}

variable "access_node_id" {
  description = "CommCell client ID of the MediaAgent / access node that proxies requests to the cluster"
  type        = number
}

variable "plan_id" {
  description = "CommCell plan ID to assign to the cluster for default scheduling"
  type        = number
}

# -----------------------------------------------------------------------
# Activity-control delay variables (used to test K8S-004)
# -----------------------------------------------------------------------

variable "backup_re_enable_timestamp" {
  description = <<EOT
UTC Unix timestamp after which CommCell will automatically re-enable backup.
Only meaningful when enablebackup = "false".  Set to 0 to leave unset.
Example: 1767225600 = 2026-01-01 00:00:00 UTC
EOT
  type    = number
  default = 0
}

variable "restore_re_enable_timestamp" {
  description = <<EOT
UTC Unix timestamp after which CommCell will automatically re-enable restore.
Only meaningful when enablerestore = "false".  Set to 0 to leave unset.
Example: 1767225600 = 2026-01-01 00:00:00 UTC
EOT
  type    = number
  default = 0
}
