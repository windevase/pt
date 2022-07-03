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