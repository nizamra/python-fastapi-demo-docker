provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "bucket" {
  name     = var.bucket_name
  location = var.region
}

resource "google_project_service" "enable_kubernetes" {
  service = "container.googleapis.com"
}

resource "google_project_service" "enable_registry" {
  service = "artifactregistry.googleapis.com"
}

resource "google_project_service" "enable_storage" {
  service = "storage.googleapis.com"
}
