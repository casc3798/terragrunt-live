include {
  path = find_in_parent_folders()
}

terraform {
    source = "git::git@github.com:casc3798/terragrunt-modules.git//rds?ref=master"
}

inputs = {
    name = "db-integrations-testing"
    allocated_storage = 5
    engine_version = "10.15"
    instance_class = "db.t3.micro"
    username = "myusername"
    password = "mypassword"
    availability_zone = "us-east-1a"
    port = 5432
    db_subnet_group_name = "vpc-subnet"
    vpc_security_group_ids = ["sg-group-id-list"]
    project = "Integrations"
    description = "Database for testing integrations"
    publicly_accessible = true
}