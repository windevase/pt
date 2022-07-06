resource "aws_route_table" "hjko_ngwrt" {
  vpc_id = aws_vpc.hjko_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.hjko_ngw.id
  }
  tags = {
    "Name" = "hjko-ngwrt"
  }
}