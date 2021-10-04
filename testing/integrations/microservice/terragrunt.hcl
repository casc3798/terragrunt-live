include {
  path = find_in_parent_folders()
}

terraform {
    source = "git::git@github.com:casc3798/terragrunt-modules.git//microservices?ref=master"
}

dependency "cluster" {
    config_path = "../../ecs_clusters/integrations"
}

dependency "lb" {
    config_path = "../../load_balancers/ms_integrations"
}

dependency "sns" {
    config_path = "../../../general/sns/topics/notifications"
}

inputs = {
    project="Integrations"
    description="Integrations"
    microservice_name = "integrations"
    environment = "testing"
    task_cpu = 256
    task_memory = 512
    task_memory_reservation = 512
    container_port = 3002
    host_port = 3002
    environment_variables = [
        {
            "name"  : "PGHOST",
            "value" : "<PGHOST:string>"
        },
        {
            "name"  : "PGUSER",
            "value" : "<PGUSER:string>"
        },
        {
            "name"  : "PGPASSWORD",
            "value" : "<PGPASSWORD:string>"
        },
        {
            "name"  : "PGDATABASE",
            "value" : "<PGDATABASE:string>"
        },
        {
            "name"  : "PGPORT",
            "value" : "<PGPORT:string>"
        },
        {
            "name"  : "3RD_API_URL",
            "value" : "<API_URL:string>"
        }
    ]
    cluster_arn = dependency.cluster.outputs.cluster_arn
    desired_count = 1
    subnets = ["subnet-list"]
    vpc_id = "vpc-id"
    lb_listener_arn = dependency.lb.outputs.lb_https_listener_arn
    route_pattern = ["/integrations/*"]
    codebuild_compute_type = "BUILD_GENERAL1_SMALL"
    codebuild_source_type = "BITBUCKET"
    codebuild_source_location = "<bitbucket_repo_url:string>"
    buildspec_path = ".ci/testing/buildspec.yml"
    codepipeline_artifact_store = <artifact_store:string>
    codepipeline_connection_arn = "<connection_arn:string>"
    codepipeline_full_repository_id = "organization/integration"
    codepipeline_branch = "develop"
    notification_detail = "BASIC"
    sns_topic_arn = dependency.sns.outputs.sns_arn
}