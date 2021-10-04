remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "my-tf-state-bucket"

    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "my-tf-state-lock"
  }
}

terraform {
  extra_arguments "common_vars" {
    commands = ["plan", "apply"]
    arguments = [
      "-var-file=${get_parent_terragrunt_dir()}/common.tfvars",
      "-var-file=${get_parent_terragrunt_dir()}/account.tfvars"
    ]
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "us-east-1"
}
EOF
}