resource "aws_security_group" "this" {
  for_each = var.security_groups.groups

  vpc_id      = var.vpc_id
  name        = coalesce(each.value.name, each.key)
  description = each.value.description

  tags = merge(var.security_groups.tags, each.value.tags, {
    Name = coalesce(each.value.name, each.key)
  })
}
