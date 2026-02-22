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
  type        = string
}
