resource "aws_vpc" "main" {
  for_each   = var.vpc
  vpc_cidr   = each.value.cidr_block
  tags       = local.vpc_tags
}


module "additional_cidr_block" {
  for_each = var.vpc
  source   = "./additional_vpc_cidr"
  additonal_cidr_block = each.value.additonal_cidr_block
}