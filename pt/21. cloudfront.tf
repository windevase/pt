#cloudfront s3와 연결, 포트 커스터마이징, ssl 유형 설정
resource "aws_cloudfront_distribution" "prod_distribution" {
    origin {
        domain_name = "${aws_s3_bucket.tbz.website_endpoint}"
        origin_id = "S3-${aws_s3_bucket.tbz.bucket}"
        custom_origin_config {
            http_port = 80
            https_port = 443
            origin_protocol_policy = "match-viewer"
            origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
        }
    }
    # By default, show index.html file -index 파일 형식 기본값
    default_root_object = "index.html"
    enabled = true
    # If there is a 404, return index.html with a HTTP 200 Response -에러 코드 출력
    custom_error_response {
        error_caching_min_ttl = 3000
        error_code = 404
        response_code = 200
        response_page_path = "/index.html"
    }
    default_cache_behavior {
        allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
        cached_methods = ["GET", "HEAD"]
        target_origin_id = "S3-${aws_s3_bucket.tbz.bucket}"
        # Forward all query strings, cookies and headers - 쿼리, 쿠키, 헤더 캐싱
        forwarded_values {
            query_string = true
        cookies {
                forward = "none"
            }
        }
        
        viewer_protocol_policy = "allow-all"
        min_ttl = 0
        default_ttl = 3600
        max_ttl = 86400
    }
    # Distributes content to US and Europe - 요금 계층 https://aws.amazon.com/ko/cloudfront/pricing/ 참고
    price_class = "PriceClass_200"
    # Restricts who is able to access this content 접속 제한 설정
    restrictions {
        geo_restriction {
            # type of restriction, blacklist, whitelist or none -지역 제한 설정
            restriction_type = "none"
        }
    }
    # SSL certificate for the service. ssl 인증서 사용 유무
    viewer_certificate {
        cloudfront_default_certificate = true
    }
}