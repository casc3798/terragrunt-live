include {
  path = find_in_parent_folders()
}

terraform {
    source = "git::git@github.com:casc3798/terragrunt-modules.git//sns/topic?ref=master"
}

inputs = {
    name = "Notifications"
    project = "Notifications"
    description = "Used for notifications delivery"
}