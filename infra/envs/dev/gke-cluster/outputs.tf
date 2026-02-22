output "cluster_endpoint" {
  description = "The cluster endpoint"
  value       = google_container_cluster.primary.endpoint
}

output "cluster_ca_certificate" {
  description = "The cluster CA certificate"
  value       = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
  sensitive   = true
}

output "location" {
  description = "The location (region) of the cluster"
  value       = google_container_cluster.primary.location
}

output "kubernetes_cluster_name" {
  description = "The name of the cluster"
  value       = google_container_cluster.primary.name
}
