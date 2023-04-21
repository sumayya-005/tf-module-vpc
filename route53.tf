resource "aws_route53_zone_association" "zone" {
  vpc_id  = aws_vpc.main.id
  zone_id = var.private_zone_id
}