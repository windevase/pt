resource "aws_placement_group" "pg" {
  name = "${format("%s-pg", var.name)}"
  strategy = "cluster"
}

resource "aws_autoscaling_group" "atsg" {
  name = "${format("%s-atsg", var.name)}"
  min_size = var.atsg.min_size
  max_size = var.atsg.max_size
  health_check_grace_period = 60
  health_check_type = "EC2"
  desired_capacity = var.atsg.desired_capacity
  force_delete = false
  launch_configuration = aws_launch_configuration.ASGlc.name
  vpc_zone_identifier = [aws_subnet.web_subnet[1].id]
}

resource "aws_autoscaling_attachment" "asatt" {
  autoscaling_group_name = aws_autoscaling_group.atsg.id
  lb_target_group_arn = aws_lb_target_group.alb_target.arn
}