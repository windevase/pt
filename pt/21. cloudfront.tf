resource "aws_cloudfront_distribution" "cdn" {
  aliases = ["${format("%s.%s", "home", var.domain)}"]

  default_cache_behavior {
    allowed_methods        = ["DELETE", "OPTIONS", "POST", "PATCH", "HEAD", "GET", "PUT"]
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    cached_methods         = ["GET", "HEAD"]
    compress               = "true"
    default_ttl            = "0"
    max_ttl                = "0"
    min_ttl                = "0"
    smooth_streaming       = "false"
    target_origin_id       = aws_s3_bucket.tbz.bucket_regional_domain_name
    viewer_protocol_policy = "redirect-to-https"
  }

  default_root_object = "index.html"
  enabled             = "true"
  http_version        = "http2"
  is_ipv6_enabled     = "true"

  origin {
    connection_attempts = "3"
    connection_timeout  = "10"
    domain_name         = aws_s3_bucket.tbz.bucket_regional_domain_name
    origin_id           = aws_s3_bucket.tbz.bucket_regional_domain_name
    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  retain_on_delete = "false"

  viewer_certificate {
    acm_certificate_arn   = aws_acm_certificate_validation.cert_validue.certificate_arn
    cloudfront_default_certificate = "false"
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }
}