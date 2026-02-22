variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}
variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
}

variable "network_name" {
  description = "The VPC network name"
  type        = string
}

variable "subnetwork_name" {
  description = "The subnetwork name"
  type        = string
}
