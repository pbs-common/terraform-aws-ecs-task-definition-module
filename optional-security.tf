variable "task_role_arn" {
  description = "(optional) ARN of an existing IAM role to use as the task role. If provided, no task role is created by this module and role-related policies are not managed."
  default     = null
  type        = string
}

variable "task_execution_role_arn" {
  description = "(optional) ARN of an existing IAM role to use as the task execution role. If provided, no task execution role is created by this module and execution role policies are not managed."
  default     = null
  type        = string
}

variable "role_policy_json" {
  description = "(optional) IAM policy to attach to role used for this task and replace defaults"
  default     = null
  type        = string
}

variable "task_execution_role_policy_json" {
  description = "(optional) IAM policy to attach to task execution role used for this task and replace defaults"
  default     = null
  type        = string
}

variable "extra_role_policy_json" {
  description = "(optional) Extra IAM policy to attach to role used for this task without replacing defaults"
  default     = null
  type        = string
}

variable "extra_task_execution_role_policy_json" {
  description = "(optional) Extra IAM policy to attach to task execution role used for this task without replacing defaults"
  default     = null
  type        = string
}

variable "runtime_platform" {
  description = "(optional) Runtime platform for the task. Defaults to LINUX operating system family w/ CPU architecture x86_64."
  default = {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  type = object({
    operating_system_family = optional(string, "LINUX")
    cpu_architecture        = optional(string, "X86_64")
  })
}

variable "task_role_name" {
  description = "(optional) Fixed name for the task IAM role. If null, a name_prefix is used instead."
  default     = null
  type        = string
}

variable "task_execution_role_name" {
  description = "(optional) Fixed name for the task execution IAM role. If null, a name_prefix is used instead."
  default     = null
  type        = string
}

variable "vpc_id" {
  description = "(optional) VPC ID for the task security group. Required when ingress_rules or egress_rules are provided."
  default     = null
  type        = string
}

variable "ingress_rules" {
  description = "(optional) List of ingress rules for the task security group. A security group is created automatically when this list is non-empty."
  default     = []
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    description     = optional(string, "")
    cidr_blocks     = optional(list(string), [])
    security_groups = optional(list(string), [])
  }))
}

variable "egress_rules" {
  description = "(optional) List of egress rules for the task security group. A security group is created automatically when this list is non-empty."
  default     = []
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    description     = optional(string, "")
    cidr_blocks     = optional(list(string), [])
    security_groups = optional(list(string), [])
  }))
}

variable "security_group_name" {
  description = "(optional) Name for the task security group. Defaults to \"<name>-task\" when not set."
  default     = null
  type        = string
}
