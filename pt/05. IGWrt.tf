resource"aws_route_table" "public_route" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }

    tags = {
        Name = "${format("%s-pubrt", var.name)}"
    }
}