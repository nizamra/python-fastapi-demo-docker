# Set up the default VPC and Subnet dynamically, no hardcode IDs
data "google_compute_network" "default" {
  name = var.vpc_network_name
}

data "google_compute_subnetwork" "default" {
  name   = "${var.vpc_network_name}-${var.region}"
  region = var.region
}

module "artifact_registry" {
  source = "./artifact-registry"

  project_id      = var.project_id
  region          = var.region
  repository_name = "bookshelf-docker-repo"
}

module "gke_cluster" {
  source = "./gke-cluster"

  project_id        = var.project_id
  region            = var.region
  cluster_name      = "bookshelf-dev-cluster"
  network_name      = data.google_compute_network.default.name
  subnetwork_name   = data.google_compute_subnetwork.default.name
}
