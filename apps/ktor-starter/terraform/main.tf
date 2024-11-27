resource "kubernetes_namespace" "app_namespace" {
  metadata {
    name = var.app_namespace
  }
}

resource "kubernetes_manifest" "ktor_starter_flux_source" {
  manifest = {
    apiVersion = "source.toolkit.fluxcd.io/v1"
    kind       = "GitRepository"
    metadata = {
      name      = var.app_name
      namespace = var.flux_namespace
    }
    spec = {
      interval = "5m"
      ref = {
        branch = "main"
      }
      url       = "ssh://git@github.com/aedenj/ktor-starter.git"
      secretRef = {
        name = "flux-system"
      }
      ignore = <<-EOF
        # exclude all
        /*
        # include deploy dir
        !/infra/aws/appV2/infra
        # exclude file extensions from deploy dir
        /infra/aws/appV2/**/*.md
        /infra/aws/appV2/**/*.txt
        /infra/aws/appV2/**/.terraform.lock.hcl
        /infra/aws/appV2/**/.terragrunt-cache
      EOF
    }
  }
}




