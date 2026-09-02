variable "helm" {
  description = "Helm releases managed in the EKS cluster."

  type = object({
    packages = map(object({
      name       = optional(string)
      enabled    = optional(bool, true)
      repository = string
      chart      = string
      version    = optional(string)
      namespace  = optional(string, "default")
      values     = optional(map(any), {})
    }))
  })
}
