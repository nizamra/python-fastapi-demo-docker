output "artifact_registry_url" {
  value = module.artifact_registry.repository_url
}

output "gke_cluster_endpoint" {
  value = module.gke_cluster.cluster_endpoint
}
