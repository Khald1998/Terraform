variable "gcp_region" {
  type        = string
  description = "Region to use for GCP provider"
  default     = "us-central1"
}

variable "gcp_project" {
  type        = string
  description = "Project to use for this config"
  default     = "terraform-31308"
}

variable "MONGODB_ATLAS_PUBLIC_KEY" {
  type    = string
  default = "fqucsetn"
}
variable "MONGODB_ATLAS_PRIVATE_KEY" {
  type    = string
  default = "af9c7d7d-1161-4e04-aeff-3d1a8f00d751"
}

