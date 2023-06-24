locals {
  project_name   = "advanced_search"
  tf_global_tags = { "IaC" : "Terraform" }
  name_tag       = { "Name" : local.project_name }
  project_tag    = { "Project" : local.project_name }
  base_tags      = merge(local.tf_global_tags, local.name_tag, local.project_tag)
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
