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

variable "vpc_name" {
  type    = string
  default = "main-vpc"
}

variable "user_email" {
  type    = string
  default = "alzahrani.khaled.98@gmail.com"
}

variable "image_name" {
  type    = string
  default = "backend"
}
variable "ssh_user" {
  default = "alzahrani_khaled_98"
}
variable "repository_name" {
  default = "my-docker-repository"
}
