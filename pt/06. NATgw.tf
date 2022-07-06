resource "aws_eip" "eip_nat" {
    count = "${length(var.region.az)}"
    vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
    count ="${length(var.region.az)}"
    allocation_id = "${aws_eip.eip_nat.*.id[count.index]}"
    subnet_id = "${aws_subnet.public.*.id[count.index]}"

    tags = {
        Name = "${format("%s-nat", var.name)}"
    }
}