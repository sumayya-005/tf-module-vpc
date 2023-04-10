#module "lm-subnets" {
#  for_each    = var.subnets
#  cidr_block  = each.value.cidr_block
#  source      = "./lm-subnets"
#  vpc_id      = var.vpc_id[0]
#  env         = var.env
#  name        = each.value.name
#  subnet_availability_zones = var.subnet_availability_zones
#  route_table_id    = lookup (lookup (aws_route_table.aws_route_table,each.value.name,null) ,"id" ,null)
#  management_vpc = var.management_vpc
#
#}

#resource "aws_route_table" "aws_route_table" {
#  for_each = var.subnets
#  vpc_id   = var.vpc_id[0]
#  tags      = {
#    Name    = "${var.env}-${each.value.name}-rt"
#    ENV     = var.env
#    PROJECT = "roboshop"
#  }
#}
#
###output "aws_route_table" {
###  value = module.lm-subnets
###}
##
###to get the subnet id.
##
##output "route-tables" {
##  value =aws_route_table.aws_route_table
##}
#
#resource "aws_route" "peering_connection_route" {
#  for_each               = var.subnets
#  route_table_id         =lookup(lookup(aws_route_table.aws_route_table,each.value.name,null), "id" ,null)
#  destination_cidr_block = lookup(var.management_vpc, "vpc_cidr", null)
#  vpc_peering_connection_id  = var.peering_connection_id
#}

resource "aws_subnet" "main" {
  count                  = length(var.cidr_block)
  vpc_id                 = var.vpc_id
  cidr_block             = element(var.cidr_block,count.index )
  tags                   = local.subnet_tags
  availability_zone      = element(var.subnet_availability_zones,count.index )

}

resource "aws_route_table_association" "route_table_association" {
  count              = length(aws_subnet.main)
  subnet_id          = element(aws_subnet.main.*.id,count.index )
  route_table_id     = var.route_table_id
}

output "subnets"{
  value = aws_subnet.main
}