module "subnets" {
  for_each = var.vpc
  source   = "./subnets"
  subnets  = each.value.subnets
  vpc_id   = [for k, v in aws_vpc.main : v.id]
  env      = var.env
  subnets_availability_zones = var.subnets_availability_zones
}