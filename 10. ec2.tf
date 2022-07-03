data "aws_ami"  "amzn"  {
    most_recent = true
    
    filter {
        name    = "name"
        values  = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }

    filter {
        name    = "virtualization-type"
        values  = ["hvm"]
    }

    owners = ["amazon"]
}

resource "aws_instance" "hjko_bastion" {
    ami = data.aws_ami.amzn.id
    instance_type = "t2.small"
    vpc_security_group_ids = [aws_security_group.hjko_sg.id]
    availability_zone = "ap-northeast-2a"
    private_ip = "10.0.0.100"
    subnet_id = aws_subnet.hjko_puba.id
    associate_public_ip_address = true
    
  
}

resource "aws_instance" "hjko_was_a" {
    ami = data.aws_ami.amzn.id
    instance_type = "t2.small"
    vpc_security_group_ids = [aws_security_group.hjko_sg.id]
    availability_zone = "ap-northeast-2a"
    private_ip = "10.0.4.10"
    subnet_id = aws_subnet.hjko_puba.id
    # associate_public_ip_address = true
    
  
}

resource "aws_instance" "hjko_was_c" {
    ami = data.aws_ami.amzn.id
    instance_type = "t2.small"
    vpc_security_group_ids = [aws_security_group.hjko_sg.id]
    availability_zone = "ap-northeast-2c"
    private_ip = "10.0.5.10"
    subnet_id = aws_subnet.hjko_pubc.id
    # associate_public_ip_address = true
    
  
}

resource "aws_instance" "hjko_web_a" {
    count = 1
    ami                     = data.aws_ami.amzn.id
    instance_type           = "t2.small"
    vpc_security_group_ids  = [aws_security_group.hjko_sg.id]
    availability_zone       = "ap-northeast-2a"
    private_ip              = "10.0.0.2${count.index}"
    subnet_id               = aws_subnet.hjko_puba.id
    # user_data = file("./install.sh")

    tags = {
        "Name"  =   "hjko-web_a${count.index}"
    } 
}

resource "aws_instance" "hjko_web_c" {
    count = 1
    ami                     = data.aws_ami.amzn.id
    instance_type           = "t2.small"
    vpc_security_group_ids  = [aws_security_group.hjko_sg.id]
    availability_zone       = "ap-northeast-2c"
    private_ip              = "10.0.1.2${count.index}"
    subnet_id               = aws_subnet.hjko_pubc.id
    # user_data = file("./install.sh")

    tags = {
        "Name"  =   "hjko-web_c${count.index}"
    } 
}

output "public_ip" {
  value = aws_instance.hjko_bastion.public_ip
}