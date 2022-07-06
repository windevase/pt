resource "aws_instance" "web" {
    count = var.web.count
    ami = var.web.ami
    instance_type = var.web.instance_type
    key_name = var.key.name
    vpc_security_group_ids = [aws_security_group.security_web.id]
    subnet_id = aws_subnet.web_subnet[(count.index)%2].id
    user_data = <<EOF
#!/bin/bash
sudo su -
sed -i "s/#Port 22/Port ${var.sg_web.0.from_port}/g" /etc/ssh/sshd_config
systemctl restart sshd
EOF

    tags = {
        Name = "web"
    }
    root_block_device {
        volume_size = 30
        tags = {
            Snapshot = "true"
        }
    }
    credit_specification{
        cpu_credits = "unlimited"
    }
}

resource "aws_instance" "was" {
    count = var.was.count
    ami = var.was.ami
    instance_type = var.was.instance_type
    key_name = var.key.name
    vpc_security_group_ids = [aws_security_group.security_was.id]
    subnet_id = aws_subnet.was_subnet[(count.index)%2].id
    user_data = <<EOF
#!/bin/bash
sudo su -
sed -i "s/#Port 22/Port ${var.sg_was.0.from_port}/g" /etc/ssh/sshd_config
systemctl restart sshd
EOF

    tags = {
        Name = "was"
    }
    root_block_device {
        volume_size = 30
        tags = {
            Snapshot = "true"
        }
    }
    credit_specification{
        cpu_credits = "unlimited"
    }
}