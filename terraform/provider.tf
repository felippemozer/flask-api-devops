terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.48.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.8.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

provider "helm" {
  kubernetes {
    host                   = module.kubernetes.endpoint
    cluster_ca_certificate = base64decode(module.kubernetes.certificate_authority)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.kubernetes.cluster_name]
      command     = "aws"
    }
  }
}
