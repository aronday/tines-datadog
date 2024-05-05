provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

provider "aws" {
  region     = var.region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key

  default_tags {
    tags = var.aws_tags
  }
}

data "aws_caller_identity" "current" {}

locals {
  aws-account-id = data.aws_caller_identity.current.account_id
}
