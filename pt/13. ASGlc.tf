resource "aws_launch_configuration" "ASGlc" {
  name = "${format("%s-ASGlc", var.name)}"
  image_id = aws_ami_from_instance.web_ami.id
  instance_type = var.ASGlc.instance_type
  iam_instance_profile = "admin_role"
  security_groups = [aws_security_group.security_web.id]
  key_name = var.key.name
  user_data = <<EOF
  #!/bin/bash
  systemctl start httpd
  systmectl restart httpd
  EOF
}