resource "aws_db_subnet_group" "this" {
  name = var.rds.subnet_group.name

  subnet_ids = [for key in var.rds.subnet_group.subnet_keys : var.subnet_ids[key]]

  tags = merge(var.rds.tags, {
    Name = var.rds.subnet_group.name
  })
}
