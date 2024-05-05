# AWS Config for Datadog AWS Integration
# https://docs.datadoghq.com/integrations/guide/aws-terraform-setup/

locals {
  resources = var.datadog_resources ? [1] : []
}

data "aws_iam_policy_document" "datadog_aws_integration_assume_role" {
  depends_on = [datadog_integration_aws.aws_integration]
  statement {
    sid     = "AllowAssumeRoleFromDatadog"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::464622532012:root"]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"

      values = [datadog_integration_aws.aws-integration.external_id]
    }
  }
}

resource "aws_iam_role" "datadog_role" {
  depends_on         = [datadog_integration_aws.aws_integration]
  name               = var.datadog-aws-role-name
  assume_role_policy = data.aws_iam_policy_document.datadog_aws_integration_assume_role.json
}

resource "aws_iam_role_policy_attachment" "security_audit" {
  depends_on = [datadog_integration_aws.aws_integration]
  role       = aws_iam_role.datadog_role.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}

resource "aws_iam_policy" "datadog_permissions" {
  depends_on = [datadog_integration_aws.aws_integration]
  name       = "datadog-integration-policy"
  policy     = file("${path.module}/datadog-integration-policy.json")
}

resource "aws_iam_role_policy_attachment" "datadog_permissions" {
  depends_on = [datadog_integration_aws.aws_integration]
  role       = aws_iam_role.datadog_role.name
  policy_arn = aws_iam_policy.datadog_permissions.arn
}

# Datadog AWS Integration
resource "datadog_integration_aws" "aws_integration" {
  for_each   = toset(local.resources)
  account_id = local.aws-account-id
  role_name  = var.datadog-aws-role-name
}