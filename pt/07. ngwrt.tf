resource"aws_route_table" "web_route" {
    count = "${length(var.cidr.web)}"
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_nat_gateway.nat_gateway[(count.index)%2].id}"
    }

    tags = {
        Name = "${format("%s-webrt", var.name)}"
    }
}

resource"aws_route_table" "was_route" {
    count = "${length(var.cidr.was)}"
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_nat_gateway.nat_gateway[(count.index)%2].id}"
    }

    tags = {
        Name = "${format("%s-wasrt", var.name)}"
    }
}