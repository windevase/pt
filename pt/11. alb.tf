resource "aws_lb" "alb" {
    name = "${format("%s-alb", var.name)}"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.security_alb.id]
    subnets = "${aws_subnet.public.*.id}"
    enable_deletion_protection = false
}

resource "aws_lb_target_group" "alb_target" {
    name = "${format("%s-alb-tg", var.name)}"
    port = "80"
    protocol = "HTTP"
    target_type = "instance"
    vpc_id = aws_vpc.vpc.id
}

resource "aws_lb_listener" "alb_front_https" {
    load_balancer_arn = aws_lb.alb.arn
    port = "443"
    protocol = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-2016-08"
    certificate_arn   = aws_acm_certificate_validation.cert_valid.certificate_arn
   
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.alb_target.arn
    }
}

resource "aws_lb_target_group_attachment" "alb_target_ass" {
    count = var.web.count
    target_group_arn = aws_lb_target_group.alb_target.arn
    target_id = aws_instance.web[count.index].id
    port = "80"
}