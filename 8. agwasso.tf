resource "aws_route_table_association" "hjko_ngwass_pria" {
  subnet_id = aws_subnet.hjko_pria.id
  route_table_id = aws_route_table.hjko_ngwrt.id
}

resource "aws_route_table_association" "hjko_ngwass_pric" {
  subnet_id = aws_subnet.hjko_pric.id
  route_table_id = aws_route_table.hjko_ngwrt.id
}

resource "aws_route_table_association" "hjko_ngwass_pridba" {
  subnet_id = aws_subnet.hjko_pridba.id
  route_table_id = aws_route_table.hjko_ngwrt.id
}

resource "aws_route_table_association" "hjko_ngwass_pridbc" {
  subnet_id = aws_subnet.hjko_pridbc.id
  route_table_id = aws_route_table.hjko_ngwrt.id
}