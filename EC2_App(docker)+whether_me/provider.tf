terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    docker = {
      source = "kreuzwerker/docker"
      version = ">= 2.12, < 3.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}
