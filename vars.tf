# Datadog
variable "datadog-aws-role-name" {
  type        = string
  default     = "DatadogAWSIntegrationRole"
  description = "Name of the AWS IAM role to create for the Datadog integration"
}

variable "datadog_resources" {
  description = "Boolean to control whether Datadog resources should be created"
  type        = bool
  default     = false
}

# AWS
variable "region" {
  description = "The AWS region to deploy in"
  type        = string
  default     = "eu-west-1"
}

variable "aws_access_key_id" {
  description = "aws account configuration"
  type        = string
  sensitive   = true
}

variable "aws_secret_access_key" {
  description = "aws account configuration"
  type        = string
  sensitive   = true
}

variable "aws_tags" {
  description = "Common tags for all resources deployed by this module"
  type        = map(string)
  default = {
    application = "tines-datadog"
    env         = "dev"
  }
}