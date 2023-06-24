provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  default_tags {
    tags = merge(local.tf_global_tags, local.project_tag, local.name_tag)
  }
}
