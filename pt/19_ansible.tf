resource "aws_instance" "ansible" {
    ami = var.ansible.ami
    instance_type = var.ansible.instance_type
    key_name = var.key.name
    vpc_security_group_ids = [aws_security_group.sg_ansible.id]
    subnet_id = aws_subnet.web_sub[0].id
    iam_instance_profile = aws_iam_instance_profile.profile_ansible.name
    user_data = <<EOF
#!/bin/bash
sed -i "s/#Port 22/Port ${var.sg_ansible.from_port}/g" /etc/ssh/sshd_config
systemctl restart sshd
sudo yum update
sudo amazon-linux-extras enable ansible2
sudo yum install -y ansible
sudo "echo '${var.key.private}' > /home/ec2-user/id_rsa"
sudo "chmod 600 /home/ec2-user/id_rsa"
EOF

    tags = {
        Name = "ansible"
    }
    root_block_device {
        volume_size = 30
    }
    credit_specification{
        cpu_credits = "unlimited"
    }
}

resource "aws_iam_instance_profile" "profile_ansible" {
  name = "${format("%s-profile-ansible", var.name)}"
  role = aws_iam_role.role_ansible.name
}

resource "aws_iam_role" "role_ansible" {
  name = "${format("%s-role-ansible", var.name)}"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "policy_ansible" {
  name = "${format("%s-policy-ansible", var.name)}"
  role = aws_iam_role.role_ansible.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
EOF
}
