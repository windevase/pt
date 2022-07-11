resource "aws_route_table_association" "public_ass" {
    count = "${length(var.cidr.pub)}"
    subnet_id = "${aws_subnet.public[count.index].id}"
    route_table_id = "${aws_route_table.public_route.id}"
}

resource "aws_route_table_association" "web_ass" {
    count = "${length(var.cidr.web)}"
    subnet_id = "${aws_subnet.web_subnet[count.index].id}"
    route_table_id = "${aws_route_table.web_route[count.index].id}"
}