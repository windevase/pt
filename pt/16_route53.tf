resource "aws_route53_zone" "route53_zone" {
  count = length(var.domain)
  name       = var.domain[count.index]
}

resource "aws_route53_record" "route53_record" {
  count = length(var.domain)
  zone_id = aws_route53_zone.route53_zone[count.index].zone_id
  name    = "${format("%s.%s", "www", var.domain[count.index])}"
  type    = "A"

  alias {
    name                   = "dualstack.${aws_lb.alb.dns_name}"
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_acm_certificate" "cert" {
  count = length(var.domain)
  domain_name       = var.domain[count.index]
  subject_alternative_names = ["*.${var.domain[count.index]}"]
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "route53_record_cert" {
  count = length(var.domain)
  zone_id = aws_route53_zone.route53_zone[count.index].zone_id
  name                   = tolist(aws_acm_certificate.cert[count.index].domain_validation_options)[0].resource_record_name
  type                   = tolist(aws_acm_certificate.cert[count.index].domain_validation_options)[0].resource_record_type
  records                = [tolist(aws_acm_certificate.cert[count.index].domain_validation_options)[0].resource_record_value]
  ttl                    = 60
}

resource "aws_acm_certificate_validation" "cert_valid" {
  count = length(var.domain)
  certificate_arn         = aws_acm_certificate.cert[count.index].arn
}
