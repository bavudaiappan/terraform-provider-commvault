output "cluster_id" {
  description = "CommCell client ID of the registered Kubernetes cluster"
  value       = commvault_kubernetes_cluster.example.id
}
