resource "aws_route_table" "public" {
        vpc_id = aws_vpc.hjko_vpc.id

        route {
                cidr_block = "0.0.0.0/0"
                gateway_id = aws_internet_gateway.hjko_ig.id
        }

        tags = {
                Name = "rt-public"
        }
}

resource "aws_route_table" "private" {
        vpc_id = aws_vpc.hjko_vpc.id

        route {
                cidr_block = "10.0.0.0/16"
                gateway_id = aws_vpc.hjko_vpc.id
        }

        tags = {
                Name = "rt-private"
        }
}

resource "aws_route_table_association" "hjko_igas_puba" {
  subnet_id       =   aws_subnet.hjko_puba.vpc_id
  route_table_id  =   aws_route_table.hjko_rt.id    
}

resource "aws_route_table_association" "hjko_igas_pubc" {
  subnet_id       =   aws_subnet.hjko_puba.vpc_id
  route_table_id  =   aws_route_table.hjko_rt.id    
}