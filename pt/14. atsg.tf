resource "aws_placement_group" "pg" {
  name = "${format("%s-pg", var.name)}"
  strategy = "cluster"
}

resource "aws_autoscaling_group" "atsg" {
  min_size = var.atsg.min_size
  max_size = var.atsg.max_size
  health_check_grace_period = 60
  health_check_type = "EC2"
  desired_capacity = var.atsg.desired_capacity
  force_delete = false
  launch_configuration = aws_launch_configuration.ASGlc.name
  vpc_zone_identifier = [aws_subnet.web_subnet[0].id, aws_subnet.web_subnet[1].id]
}

resource "aws_autoscalingplans_scaling_plan" "asp" {
  name = "${format("%s-predictive-cost-SSoptimization", var.name)}"

  application_source {
    tag_filter {
      key    = "application"
      values = ["asp"]
    }
  }

  scaling_instruction {
    disable_dynamic_scaling = true

    max_capacity       = 10
    min_capacity       = 2
    resource_id        = format("autoScalingGroup/%s", aws_autoscaling_group.atsg.name)
    scalable_dimension = "autoscaling:autoScalingGroup:DesiredCapacity"
    service_namespace  = "autoscaling"

    target_tracking_configuration {
      predefined_scaling_metric_specification {
        predefined_scaling_metric_type = "ASGAverageCPUUtilization"
      }

      target_value = 50
    }

    predictive_scaling_max_capacity_behavior = "SetForecastCapacityToMaxCapacity"
    predictive_scaling_mode                  = "ForecastAndScale"

    predefined_load_metric_specification {
      predefined_load_metric_type = "ASGTotalCPUUtilization"
    }
  }
}

resource "aws_autoscaling_attachment" "asatt" {
  autoscaling_group_name = aws_autoscaling_group.atsg.id
  lb_target_group_arn = aws_lb_target_group.alb_target.arn
}