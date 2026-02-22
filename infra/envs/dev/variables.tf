variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

# Network variables
variable "vpc_network_name" {
  description = "The name of the VPC network (usually 'default' for new projects)"
  default     = "default"
}

variable "vpc_subnetwork_name" {
  description = "The name of the subnetwork (usually 'default' for the region)"
  # Note: We construct the default subnet name dynamically in main.tf usually, 
  # but let's just pass a specific string or use data sources.
  # For this exercise, we will assume standard GCP default naming convention.
}