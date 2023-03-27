module "subnets" {
  for_each = var.vpc
  source   = "./subnets"
  subnets  = each.value.subnets
}