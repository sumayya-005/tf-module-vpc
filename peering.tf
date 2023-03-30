resource "aws_vpc_peering_connection" "management-vpc-to-env-vpc" {
  count         = lenght
  peer_vpc_id   = lookup(var.management_vpc,"vpc_id", null)
  vpc_id        = element([for k, v in aws_vpc.main : v.id],0)
}