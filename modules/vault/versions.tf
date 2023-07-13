terraform {
  required_version = ">= 0.15"
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.17.0"
    }
  }
}

