module "lm-subnets" {
  for_each    = var.subnets
  cidr_block  = each.value.cidr_block
  source      = "./lm-subnets"
  vpc_id      = var.vpc_id[0]
  env         = var.env
  name        = each.value.name
  subnet_availability_zones = var.subnet_availability_zones
  route_table_id    = lookup (lookup (aws_route_table.aws_route_table,each.value.name,null) ,"id" ,null)
  management_vpc = var.management_vpc

}

resource "aws_route_table" "aws_route_table" {
  for_each = var.subnets
  vpc_id   = var.vpc_id[0]
  tags      = {
    Name    = "${var.env}-${each.value.name}-rt"
    ENV     = var.env
    PROJECT = "roboshop"
  }
}

##output "aws_route_table" {
##  value = module.lm-subnets
##}
#
##to get the subnet id.
#
#output "route-tables" {
#  value =aws_route_table.aws_route_table
#}

resource "aws_route" "peering_connection_route" {
  for_each               = var.subnets
  route_table_id         =lookup(lookup(aws_route_table.aws_route_table,each.value.name,null), "id" ,null)
  destination_cidr_block = lookup(var.management_vpc, "vpc_cidr", null)
  vpc_peering_connection_id  = var.peering_connection_id
}

#resource "aws_route" "internet_gateway_connection_route" {
#  for_each                   = var.subnets
#  route_table_id             =lookup(lookup(aws_route_table.aws_route_table,each.value.name,null), "id" ,null)
#  destination_cidr_block     = lookup(var.management_vpc, "vpc_cidr", null)
#  vpc_peering_connection_id  = var.peering_connection_id
#}

locals {
  subnets_list = flatten([ for i,j in module.lm-subnets: j.subnets])
}
output "subnets" {
  value = local.subnets_list[*].id
}


#output "subnets" {
#  value = module.lm-subnets
#}

##output "route_tables" {
##  value = aws_route_table.aws_route_table
#}
#resource "null_resource" "test" {
#  provisioner "local-exec" {
#    command = "echo ${module.lm-subnets}"
#  }
#}

