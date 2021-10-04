include {
  path = find_in_parent_folders()
}

terraform {
    source = "git::git@github.com:casc3798/terragrunt-modules.git//loadbalancers?ref=master"
}

inputs = {
    project="Microservices"
    lb_name="microservices-lb"
    internal=false
    subnets=["subnet-list"]
    security_group="security-group"
}