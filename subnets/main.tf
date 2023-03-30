module "lm-subnets" {
  for_each    = var.subnets
  cidr_block  = each.value.cidr_block
  source      = "./lm-subnets"
  vpc_id      = var.vpc_id[0]
  env         = var.env
  name        =each.value.name
  subnet_availability_zones = var.subnet_availability_zones
  route_table_id    = lookup(aws_route_table.route_table,each.value.name,null)
}

resource "aws_route_table" "route_table" {
  for_each = var.subnets
  vpc_id   = var.vpc_id[0]
  tag      = {

    Name    = "${var.env}-${each.value.name}-rt"
    ENV     = var.env
    PROJECT = "roboshop"
  }
}