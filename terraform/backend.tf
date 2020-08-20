locals {
  # update this per terraform project
  project_name = "advanced_search"

  # this should be a module or something
  tf_global_tags   = { "IaC" : "Terraform" }
  project_name_tag = { "Name" : local.project_name }
  base_tags        = merge(local.tf_global_tags, local.project_name_tag)
}

# Backend bootstrapped in: https://github.com/robbintt/radiant-infra.git
# Update the key for the project
terraform {
  backend "s3" {
    bucket         = "terraform-backend-27aef5ec-0ff5-454f-82b4-23d3162f03a5"
    dynamodb_table = "terraform-backend-27aef5ec-0ff5-454f-82b4-23d3162f03a5-state-lock"
    key            = "advanced_search.tfstate"
    region         = "us-east-1"
  }
}
