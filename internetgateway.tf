resource "aws_internet_gateway" "gw" {
  count = length (local.vpc_ids)
  vpc_id = aws_vpc.main.id

  tags ={
    Name = "${var.env}-igw"
  }
}



