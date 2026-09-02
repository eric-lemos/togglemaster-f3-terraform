variable "elasticache" {
  description = "ElastiCache configuration (subnet group and cache clusters). Subnet ids and security group ids can be referenced by id or by Name tag."

  type = object({
    subnet_group = object({
      name        = optional(string)
      subnet_keys = list(string)
    })

    # Map key = logical cache cluster identifier (e.g. "sessions", "cache")
    clusters = map(object({
      name                 = optional(string)
      engine               = optional(string, "redis")
      engine_version       = optional(string, "7.1")
      node_type            = optional(string, "cache.t3.micro")
      num_cache_nodes      = optional(number, 1)
      port                 = optional(number, 6379)
      parameter_group_name = optional(string)
      security_group_keys  = optional(list(string), [])
      apply_immediately    = optional(bool, true)
      tags                 = optional(map(string), {})
    }))

    tags = optional(map(string), {})
  })

  validation {
    condition     = length(var.elasticache.subnet_group.subnet_keys) > 0
    error_message = "elasticache.subnet_group must provide at least one subnet key."
  }
}

variable "subnet_ids" {
  description = "Subnet IDs indexed by logical subnet key."
  type        = map(string)
}

variable "security_group_ids" {
  description = "Security group IDs indexed by logical security group key."
  type        = map(string)
}
