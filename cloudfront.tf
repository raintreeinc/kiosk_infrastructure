resource "aws_s3_bucket" "scdfnt" {
  bucket = "${lower(local.local_data.tag_prefix)}-s3-frontend-webapp-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  acl    = "private"
  versioning {
    enabled = false
  }
  website {
    index_document = "index.html"
    error_document = "error.html"
 }
  tags = {
    Environment = "development"
    Name        = "my-tag"
  }
}
resource "aws_s3_bucket_object" "html" {
  for_each = fileset("../../mywebsite/", "**/*.html")
  bucket = aws_s3_bucket.scdfnt.bucket
  key    = each.value
  source = "../../mywebsite/${each.value}"
  etag   = filemd5("../../mywebsite/${each.value}")
  content_type = "text/html"
}
resource "aws_s3_bucket_object" "svg" {
  for_each = fileset("../../mywebsite/", "**/*.svg")
  bucket = aws_s3_bucket.scdfnt.bucket
  key    = each.value
  source = "../../mywebsite/${each.value}"
  etag   = filemd5("../../mywebsite/${each.value}")
  content_type = "image/svg+xml"
}
resource "aws_s3_bucket_object" "css" {
  for_each = fileset("../../mywebsite/", "**/*.css")
  bucket = aws_s3_bucket.scdfnt.bucket
  key    = each.value
  source = "../../mywebsite/${each.value}"
  etag   = filemd5("../../mywebsite/${each.value}")
  content_type = "text/css"
}
resource "aws_s3_bucket_object" "js" {
  for_each = fileset("../../mywebsite/", "**/*.js")
  bucket = aws_s3_bucket.scdfnt.bucket
  key    = each.value
  source = "../../mywebsite/${each.value}"
  etag   = filemd5("../../mywebsite/${each.value}")
  content_type = "application/javascript"
}
resource "aws_s3_bucket_object" "images" {
  for_each = fileset("../../mywebsite/", "**/*.png")
  bucket = aws_s3_bucket.scdfnt.bucket
  key    = each.value
  source = "../../mywebsite/${each.value}"
  etag   = filemd5("../../mywebsite/${each.value}")
  content_type = "image/png"
}
resource "aws_s3_bucket_object" "json" {
  for_each = fileset("../../mywebsite/", "**/*.json")
  bucket = aws_s3_bucket.scdfnt.bucket
  key    = each.value
  source = "../../mywebsite/${each.value}"
  etag   = filemd5("../../mywebsite/${each.value}")
  content_type = "application/json"
}
output "fileset-results" {
  value = fileset("../../mywebsite/", "**/*")
}
locals {
  s3_origin_id = "s3-my-webapp.example.com"
}
resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "s3-my-webapp.example.com"
}
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.scdfnt.bucket_regional_domain_name
    origin_id   = local.s3_origin_id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "my-cloudfront"
  default_root_object = "index.html"
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
   ordered_cache_behavior {
    path_pattern     = "index.html"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.s3_origin_id
    forwarded_values {
      query_string = false
      headers      = ["Origin"]
      cookies {
        forward = "none"
      }
    }
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }
  
  custom_error_response {
    error_caching_min_ttl = 0
    error_code            = 403
    response_code         = 403
    response_page_path    = "/index.html"
  }
    custom_error_response {
    error_caching_min_ttl = 0
    error_code            = 404
    response_code         = 404
    response_page_path    = "/index.html"
  }
  price_class = "PriceClass_200"
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE", "IN"]
    }
  }
  tags = {
    Environment = "development"
    Name        = "my-tag"
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}
data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.scdfnt.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }
}
resource "aws_s3_bucket_policy" "scdfnt" {
  bucket = aws_s3_bucket.scdfnt.id
  policy = data.aws_iam_policy_document.s3_policy.json
}
resource "aws_s3_bucket_public_access_block" "scdfnt" {
  bucket = aws_s3_bucket.scdfnt.id
  block_public_acls       = true
  block_public_policy     = true
  //ignore_public_acls      = true
  //restrict_public_buckets = true
}


resource "aws_acm_certificate" "cert" {
  domain_name       = "sample.koyasiva.tech"
  validation_method = "DNS"
  tags = {
    Environment = "test"
  }



 lifecycle {
    create_before_destroy = true
  }
}




resource "aws_acm_certificate_validation" "example" {
  certificate_arn = aws_acm_certificate.cert.arn
  validation_record_fqdns =
}
