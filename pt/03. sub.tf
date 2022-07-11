#  pub sub
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.vpc.id
    count = "${length(var.cidr.pub)}"
    cidr_block = "${var.cidr.pub[count.index]}"
    availability_zone = "${var.region.region}${var.region.az[count.index]}"

    tags = {
        Name = "${format("pub-%s", var.region.az[count.index])}" 
    }
}

resource "aws_subnet" "web_subnet" {
    vpc_id = aws_vpc.vpc.id
    count = "${length(var.cidr.web)}"
    cidr_block = "${var.cidr.web[count.index]}"
    availability_zone = "${var.region.region}${var.region.az[count.index]}"

    tags = {
        Name = "${format("web-%s", var.region.az[count.index])}" 
    }
}

resource "aws_subnet" "db_subnet" {
    vpc_id = aws_vpc.vpc.id
    count = "${length(var.cidr.db)}"
    cidr_block = "${var.cidr.db[count.index]}"
    availability_zone = "${var.region.region}${var.region.az[count.index]}"

    tags = {
        Name = "${format("db-%s", var.region.az[count.index])}" 
    }
}

resource "aws_db_subnet_group" "db_subnet_group" {
    name = "${format("%s-db-sg", var.name)}"
    subnet_ids = "${aws_subnet.db_subnet.*.id}"

    tags = {
        name = "${format("%s-db-sg", var.name)}"
    }
}

resource "aws_subnet" "ansible_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.cidr.web[0]
    availability_zone = "${var.region.region}${var.region.az[0]}"

    tags = {
        Name = "ansible" 
    }
}