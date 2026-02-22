output "repository_url" {
  description = "Full URL of the docker repository"
  value       = google_artifact_registry_repository.docker_repo.registry_uri
}
