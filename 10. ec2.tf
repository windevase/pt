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

resource "aws_instance" "hjko_cont" {
    ami = data.aws_ami.amzn.id
    instance_type = "t2.small"
    vpc_security_group_ids = [aws_security_group.hjko_sg.id]
    availability_zone = "ap-northeast-2a"
    private_ip = "10.0.0.10"
    subnet_id = aws_subnet.hjko_puba.id
    associate_public_ip_address = true
    
  
}
resource "aws_instance" "hjko_ann" {
    count = 3
    ami                     = data.aws_ami.amzn.id
    instance_type           = "t2.small"
    vpc_security_group_ids  = [aws_security_group.hjko_sg.id]
    availability_zone       = "ap-northeast-2a"
    private_ip              = "10.0.0.2${count.index}"
    subnet_id               = aws_subnet.hjko_puba.id
    # user_data = file("./install.sh")

    tags = {
        "Name"  =   "hjko-ann${count.index}"
    } 
}

output "public_ip" {
  value = aws_instance.hjko_cont.public_ip
}