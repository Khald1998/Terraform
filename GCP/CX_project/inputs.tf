variable "gcp_region" {
  type        = string
  description = "Region to use for GCP provider"
  default     = "us-central1"
}

variable "gcp_project" {
  type        = string
  description = "Project to use for this config"
  default = "terraform-31308"
}

variable "vpc_name" {
  type    = string
  default = "main-vpc"
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  type    = string
  default = "10.0.0.0/24"
}

variable "EC2_name" {
  type    = string
  default = "web-app"
}
variable "repository_name" {
  type    = string
  default = "my_repository"
}