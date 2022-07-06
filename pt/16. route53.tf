resource "aws_route53_zone" "route53_zone" {
  name       = var.domain
}

resource "aws_route53_record" "route53_record" {
  zone_id = aws_route53_zone.route53_zone.zone_id
  name    = "${format("%s.%s", var.name, var.domain)}"
  type    = "A"

  alias {
    name                   = "dualstack.${aws_lb.alb.dns_name}"
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}