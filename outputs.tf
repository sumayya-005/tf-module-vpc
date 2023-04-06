#locals {
#  route_tables = flatten([ for i,j in module.lm-subnets: j.subnets])
#}
#output "subnets" {
#  value = local.subnets_list[*].id
#}

