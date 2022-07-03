resource "aws_lb" "hjko_alb" {
  name = "hjko-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.hjko_sg.id]
  subnets = [aws_subnet.hjko_puba.id,aws_subnet.hjko_pubc.id]
  tags = {
    "Name" = "hjko-alb"
  }
}

output "dns_name" {
  value = aws_lb.hjko_alb.dns_name
}

resource "aws_lb_target_group" "alb_target" {
    name = "hjko-albtg"
    port = "80"
    protocol = "HTTP"
    target_type = "instance"
    vpc_id = aws_vpc.hjko_vpc.id

}

resource "aws_lb_listener" "alb_front_http" {
    load_balancer_arn = aws_lb.hjko_alb.arn
    port = "80"
    protocol = "HTTP"
  
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.alb_target.arn
    }
}