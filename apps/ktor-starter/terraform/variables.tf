variable "cluster_name" {
    description = "The name of the EKS cluster"
    type        = string
}

variable "app_namespace" {
    description = "The namespace to deploy the application to"
    type        = string
}

variable "app_name" {
    description = "The name of the application"
    type        = string
}

variable "flux_namespace" {
    description = "The namespace flux is deployed to"
    type        = string
}

