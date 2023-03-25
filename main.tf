resource "aws_vpc" "main" {
  for_each   = var.vpc
  vpc_cidr   = each.value.cidr_block
  tags       = local.vpc_tags
}