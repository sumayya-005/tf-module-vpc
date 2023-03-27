resource "aws_subnet" "main" {
  count      =length(
  vpc_id     = var.vpc_id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}