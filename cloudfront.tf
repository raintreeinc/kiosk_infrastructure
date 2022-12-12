resource "aws_s3_bucket" "scdfnt" {
  bucket = "${lower(local.local_data.tag_prefix)}-frontend-webapp-s3-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  acl    = "private"
  versioning {
    enabled = false
  }
  website {
    index_document = "index.html"
    error_document = "error.html"
 }
  tags = {
    Environment = "${lower(local.local_data.tag_env)}"
    Name        = "${lower(local.local_data.tag_prefix)}-frontend-webapp-s3-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
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
  s3_origin_id = "${lower(local.local_data.tag_prefix)}-webapp-origin-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
#  s3_origin_id = "kiosk.sqa.raintreeinc.com"
}
resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
#  comment = "kiosk.dev.raintreeinc.com"
  comment = "${lower(local.local_data.tag_prefix)}-webapp-origin-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
}
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.scdfnt.bucket_regional_domain_name
    origin_id   = local.s3_origin_id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }
  #aliases           = ["*.dev.raintreeinc.com"]
  aliases           = ["*.${lower(local.local_data.tag_env)}.raintreeinc.com"]
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "${lower(local.local_data.tag_prefix)}-cloudfront-dstribution-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
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
    compress               = true
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
      restriction_type = "none"
      locations        = []
    }
  }
  tags = {
    Environment = "${lower(local.local_data.tag_env)}"
    Name        = "${lower(local.local_data.tag_prefix)}-cloudfront-dstribution-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  }
  viewer_certificate {
    cloudfront_default_certificate = true
#    acm_certificate_arn      = "arn:aws:acm:us-east-1:106367354196:certificate/809e311a-024e-4c98-bc72-3ae368a577af"
    acm_certificate_arn = "${lower(local.local_data.acm_certificate_arn)}"
    minimum_protocol_version = "TLSv1.1_2016"
    ssl_support_method       = "sni-only"
#    domain_name       = "org1.dev.raintreeinc.com"
  }
}

locals {
  domain_name =  aws_cloudfront_distribution.s3_distribution.domain_name
}

output "domain_name" {
  value = local.domain_name
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


resource "aws_route53_record" "cdn-cname" {
  zone_id = "${lower(local.local_data.zone_id)}"
  name    = "org1-kiosk.${lower(local.local_data.tag_env)}.raintreeinc.com"
  type    = "CNAME"
  ttl     = "300"
  records = ["${local.domain_name}"]
}
