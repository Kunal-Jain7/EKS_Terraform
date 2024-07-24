terraform {
  required_version = ">= 1.5.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}