resource "aws_launch_configuration" "hjko_lacf" {
  name = "hjko-lacf"
  image_id = aws_ami_from_instance.hjko_ami.id
  instance_type = "t2.micro"
  iam_instance_profile = "admin_role"
  security_groups = [aws_security_group.hjko_sg.id]
  key_name = "hjko-key"
  user_data = <<EOF
  #!/bin/bash
  systemctl start httpd
  systmectl restart httpd
  EOF
}