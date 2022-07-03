resource "aws_route53_zone" "route53_zone" {
  name       = "hjko-domain"
}

resource "aws_route53_record" "route53_record" {
  zone_id = aws_route53_zone.route53_zone.zone_id
  name    = "khj76.xyz"
  type    = "A"

  alias {
    name                   = "dualstack.${aws_lb.hjko_alb.dns_name}"
    zone_id                = aws_lb.hjko_alb.zone_id
    evaluate_target_health = true
  }
}