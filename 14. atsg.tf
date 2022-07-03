resource "aws_placement_group" "hjko_pg" {
  name = "hjko-pg"
  strategy = "cluster"
}

resource "aws_autoscaling_group" "hjko_atsg" {
  name = "hjko-atsg"
  min_size = 2
  max_size = 10
  health_check_grace_period = 60
  health_check_type = "EC2"
  desired_capacity = 2
  force_delete = false
  launch_configuration = aws_launch_configuration.hjko_lacf.name
  vpc_zone_identifier = [aws_subnet.hjko_puba.id, aws_subnet.hjko_pubc.id]
}

resource "aws_autoscaling_attachment" "hjko_asatt" {
  autoscaling_group_name = aws_autoscaling_group.hjko_atsg.id
  lb_target_group_arn = aws_lb_target_group.alb_target.arn
}