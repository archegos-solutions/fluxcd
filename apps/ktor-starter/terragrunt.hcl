include "root" {
  path = find_in_parent_folders()
  expose = true
}

terraform {
  source = ".//terraform"
}

inputs = {
  cluster_name = "${include.root.locals.cluster_name}"
  flux_namespace = "${include.root.locals.flux_namespace}"
  app_namespace = "ktor-starter"
  app_name = "ktor-starter"
}