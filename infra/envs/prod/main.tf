# Set up the default VPC and Subnet dynamically, no hardcode IDs
data "google_compute_network" "vpc" {
  name = var.vpc_network_name
}

data "google_compute_subnetwork" "default" {
  name   = "default"
  region = var.region
}

module "artifact_registry" {
  source = "../../modules/artifact-registry"

  project_id      = var.project_id
  region          = var.region
  repository_name = "bookshelf-docker-repo"
}

module "gke_cluster" {
  source = "../../modules/gke-cluster"

  project_id      = var.project_id
  region          = var.region
  cluster_name    = "bookshelf-prod-cluster"
  network_name    = data.google_compute_network.vpc.name
  subnetwork_name = data.google_compute_subnetwork.default.name
}
