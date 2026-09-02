resource "aws_elasticache_subnet_group" "this" {
  name = var.elasticache.subnet_group.name

  subnet_ids = [for key in var.elasticache.subnet_group.subnet_keys : var.subnet_ids[key]]

  tags = merge(var.elasticache.tags, {
    Name = var.elasticache.subnet_group.name
  })
}
