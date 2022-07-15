# S3 버켓 생성
resource "aws_s3_bucket" "tbz" {
  bucket = var.domain[0]

  lifecycle {
    ignore_changes = [
      website
    ]
  }
}

# S3 버켓 ACL 권한 설정
resource "aws_s3_bucket_acl" "tbz_bucket_acl" {
  bucket = aws_s3_bucket.tbz.id
  acl    = "public-read"
}

# S3 정적 웹 호스팅 설정
resource "aws_s3_bucket_website_configuration" "tbzweb" {
  bucket = aws_s3_bucket.tbz.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}

#s3 버켓에 파일 업로드
resource "aws_s3_object" "upload" {
  for_each = fileset("./documents/", "**")
  bucket = aws_s3_bucket.tbz.bucket
  key = each.value
  source = "./documents/${each.value}"
  etag = filemd5("./documents/${each.value}")
}