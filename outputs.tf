output "arn" {
  description = "Task definition ARN"
  value       = aws_ecs_task_definition.task_def.arn
}

output "role_arn" {
  description = "IAM role ARN"
  value       = aws_iam_role.task_role.arn
}

output "container_definitions" {
  description = "Task definition container definitions"
  value       = local.container_definitions
}

output "security_group_id" {
  description = "Task security group ID. Null when no ingress_rules or egress_rules are defined."
  value       = length(var.ingress_rules) > 0 || length(var.egress_rules) > 0 ? aws_security_group.task_sg[0].id : null
}
