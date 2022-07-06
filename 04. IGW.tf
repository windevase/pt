resource "aws_internet_gateway" "hjko_ig" {
  vpc_id = aws_vpc.hjko_vpc.id

  tags = {
    "Name" = "hjko-ig"
  }
}