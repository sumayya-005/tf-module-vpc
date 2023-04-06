resource "aws_internet_gateway" "gw" {
  count = length (local.vpc_ids)
  vpc_id = element(local.vpc_ids,count.index)

  tags ={
    Name = "${var.env}-igw"
  }
}


resource "aws_eip" "ngw" {
  vpc      = true
}


#resource "aws_nat_gateway" "ngw" {
#  allocation_id = aws_eip.ngw.id
#  subnet_id     = aws_subnet.example.id
#
#  tags   = {
#    Name = "gw NAT"
#  }
#}

#resource "aws_route" "internet_gateway_route_to_public_subnets" {
#  count  = length(???)
#  route_table_id = element(??,count.index )
#  destination_cidr_block = each.value.cidr_block
#  vpc_peering_connection _id =
#}