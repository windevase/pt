resource "aws_eip" "hjko_ngw_ip" {
  vpc = true
}

resource "aws_nat_gateway" "hjko_ngw" {
  allocation_id = aws_eip.hjko_ngw_ip.id
  subnet_id     = aws_subnet.hjko_puba.id
  tags = {
    "Name" = "hjko-ngw"
  } 
}