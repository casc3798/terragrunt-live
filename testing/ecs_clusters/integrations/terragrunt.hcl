include {
  path = find_in_parent_folders()
}

terraform {
    source = "git::git@github.com:casc3798/terragrunt-modules.git//ecs-clusters?ref=master"
}

inputs = {
    project="Microservices"
    cluster_name="integrations-testing"
}