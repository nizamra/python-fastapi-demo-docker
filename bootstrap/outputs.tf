output "bucket_name" {
  description = "The name of the created storage bucket"
  value       = google_storage_bucket.bucket.name
}

output "enabled_services" {
  description = "List of enabled services"
  value = [
    google_project_service.enable_kubernetes.service,
    google_project_service.enable_registry.service,
    google_project_service.enable_storage.service
  ]
}
