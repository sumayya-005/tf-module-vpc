resource "aws_vpc_peering_connection" "management-vpc-to-env-vpc" {
  peer_vpc_id   = aws_vpc.bar.id
  vpc_id        = element([for k, v in aws_vpc.main : v.id],0)
}