locals {
  name                            = var.name != null ? var.name : var.product
  task_family                     = var.task_family != null ? var.task_family : local.service_name
  service_name                    = var.service_name != null ? var.service_name : local.name
  log_group_name                  = var.log_group_name != null ? var.log_group_name : local.log_name
  ssm_path                        = var.ssm_path != null ? var.ssm_path : "/${var.environment}/${local.task_family}/"
  container_name                  = local.use_virtual_gateway_def ? "envoy" : var.container_name != null ? var.container_name : "app"
  role_policy_json                = var.role_policy_json != null ? var.role_policy_json : local.use_virtual_gateway_def ? one(data.aws_iam_policy_document.vgw_policy_doc[*].json) : one(data.aws_iam_policy_document.policy_doc[*].json)
  task_execution_role_policy_json = var.task_execution_role_policy_json != null ? var.task_execution_role_policy_json : one(data.aws_iam_policy_document.task_execution_role_policy_doc[*].json)

  effective_task_role_arn           = var.task_role_arn != null ? var.task_role_arn : one(aws_iam_role.task_role[*].arn)
  effective_task_execution_role_arn = var.task_execution_role_arn != null ? var.task_execution_role_arn : one(aws_iam_role.task_execution_role[*].arn)
  get_newrelic_secret               = var.newrelic_secret_arn == null && var.newrelic_secret_name != null
  newrelic_secret_arn               = var.newrelic_secret_arn != null ? var.newrelic_secret_arn : local.get_newrelic_secret ? data.aws_secretsmanager_secret.newrelic_secret[0].arn : ""

  creator = "terraform"

  defaulted_tags = merge(
    var.tags,
    {
      Name                                      = local.name
      "${var.organization}:billing:product"     = var.product
      "${var.organization}:billing:environment" = var.environment
      "${var.organization}:billing:owner"       = var.owner
      creator                                   = local.creator
      repo                                      = var.repo
    }
  )

  tags = merge({ for k, v in local.defaulted_tags : k => v if lookup(data.aws_default_tags.common_tags.tags, k, "") != v })
}

data "aws_default_tags" "common_tags" {}
