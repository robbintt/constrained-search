# ref: https://www.terraform.io/docs/providers/aws/index.html
provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
  # default credentials file
  shared_credentials_file = "~/.aws/credentials"
  # this isn't working, not sure why
  #profile                 = "terraform"
}
