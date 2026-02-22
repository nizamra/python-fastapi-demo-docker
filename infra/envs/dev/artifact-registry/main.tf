resource "google_artifact_registry_repository" "docker_repo" {
  location      = var.region
  repository_id = var.repository_name
  description   = "Docker repository for BookShelf API"
  format        = "DOCKER"

  # Cleanup policy to keep costs down in Dev
  cleanup_policies {
    id     = "delete-old-untagged"
    action = "DELETE"
    condition {
      tag_state = "UNTAGGED"
      older_than = "7d"
    }
  }
}