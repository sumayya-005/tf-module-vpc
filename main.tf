resource "aws_vpc" "main" {
  for_each   = var.vpc
  vpc_cidr   = each.value.cidr_block
  tags       = local.vpc_tags
}


#module "additional_cidr_block" {
#  for_each = var.vpc
#  source   = "./additional_vpc_cidr"
#  additional_cidr_block = each.value.additional_cidr_block
#  vpc_id = var.vpc_id
#}

output "vpc" {
  value = aws_vpc_main
}