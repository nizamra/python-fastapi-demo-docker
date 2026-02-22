terraform {
  backend "gcs" {
    bucket = "gcp-passline-481414-tf-state"
    prefix = "passline/prod"
  }
}