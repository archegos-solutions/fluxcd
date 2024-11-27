locals {
    org = "archegos"
    region = "us-east-1"
    env = "dev"

    cluster_name = "archegos-dev-eks"
    flux_namespace = "flux-system"
}

remote_state {
  backend = "s3"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "terraform-state-${local.org}-${local.region}"
    key = "${local.env}/flux/${path_relative_to_include()}/terraform.tfstate"
    encrypt = false
    region = "${local.region}"
    profile = "default"
  }
}

generate "providers" {
  path = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
    terraform {
      required_providers {
        kubernetes = {
          source  = "hashicorp/kubernetes"
          version = "2.34.0"
        }
      }
    }

    data "aws_eks_cluster" "this" {
      name = var.cluster_name
    }

    data "aws_eks_cluster_auth" "this" {
      name = var.cluster_name
    }

    provider "kubernetes" {
      host                   = data.aws_eks_cluster.this.endpoint
      cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
      token                  = data.aws_eks_cluster_auth.this.token
    }
  EOF
}
