resource "aws_s3_bucket" "new" {
  bucket        = "${lower(local.local_data.tag_prefix)}-s3-forms-webapp-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  tags = {
    Name        = "${lower(local.local_data.tag_prefix)}-s3-forms-webapp-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  }
  lifecycle {
    ignore_changes = [
      server_side_encryption_configuration
    ]
  }
}

# resource "aws_s3_bucket_acl" "new" {
#   bucket                = aws_s3_bucket.new.id
#   acl                   = "private"
# }

resource "aws_s3_bucket_server_side_encryption_configuration" "new" {
  bucket                = aws_s3_bucket.new.bucket
  rule {
    apply_server_side_encryption_by_default {
#      kms_master_key_id = data.aws_kms_key.new.id
       sse_algorithm     = "AES256"
        
    }
  }
}

resource "aws_s3_bucket_versioning" "new" {
  bucket = aws_s3_bucket.new.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_website_configuration" "new" {
  bucket = aws_s3_bucket.new.bucket

  index_document {
    suffix = "index.html"
  }
}



resource "aws_s3_bucket" "scdfntnew" {
  bucket = "${lower(local.local_data.tag_prefix)}-s3-forms-webapp-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
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
    Name        = "${lower(local.local_data.tag_prefix)}-s3-forms-webapp-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  }
}
resource "aws_s3_bucket_object" "htmlnew" {
  for_each = fileset("../../mywebsite/", "**/*.html")
  bucket = aws_s3_bucket.scdfntnew.bucket
  key    = each.value
  source = "../../mywebsite/${each.value}"
  etag   = filemd5("../../mywebsite/${each.value}")
  content_type = "text/html"
}
resource "aws_s3_bucket_object" "svgnew" {
  for_each = fileset("../../mywebsite/", "**/*.svg")
  bucket = aws_s3_bucket.scdfntnew.bucket
  key    = each.value
  source = "../../mywebsite/${each.value}"
  etag   = filemd5("../../mywebsite/${each.value}")
  content_type = "image/svg+xml"
}
resource "aws_s3_bucket_object" "cssnew" {
  for_each = fileset("../../mywebsite/", "**/*.css")
  bucket = aws_s3_bucket.scdfntnew.bucket
  key    = each.value
  source = "../../mywebsite/${each.value}"
  etag   = filemd5("../../mywebsite/${each.value}")
  content_type = "text/css"
}
resource "aws_s3_bucket_object" "jsnew" {
  for_each = fileset("../../mywebsite/", "**/*.js")
  bucket = aws_s3_bucket.scdfntnew.bucket
  key    = each.value
  source = "../../mywebsite/${each.value}"
  etag   = filemd5("../../mywebsite/${each.value}")
  content_type = "application/javascript"
}
resource "aws_s3_bucket_object" "imagesnew" {
  for_each = fileset("../../mywebsite/", "**/*.png")
  bucket = aws_s3_bucket.scdfntnew.bucket
  key    = each.value
  source = "../../mywebsite/${each.value}"
  etag   = filemd5("../../mywebsite/${each.value}")
  content_type = "image/png"
}
resource "aws_s3_bucket_object" "jsonnew" {
  for_each = fileset("../../mywebsite/", "**/*.json")
  bucket = aws_s3_bucket.scdfntnew.bucket
  key    = each.value
  source = "../../mywebsite/${each.value}"
  etag   = filemd5("../../mywebsite/${each.value}")
  content_type = "application/json"
}
output "fileset-results-new" {
  value = fileset("../../mywebsite/", "**/*")
}
locals {
  s3_origin_id_new = "${lower(local.local_data.tag_prefix)}-forms-webapp-origin-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
#  s3_origin_id = "kiosk.sqa.raintreeinc.com"
}
resource "aws_cloudfront_origin_access_identity" "origin_access_identity_new" {
#  comment = "kiosk.dev.raintreeinc.com"
  comment = "${lower(local.local_data.tag_prefix)}-forms-webapp-origin-new-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
}
resource "aws_cloudfront_distribution" "s3_distribution_new" {
  origin {
    domain_name = aws_s3_bucket.scdfntnew.bucket_regional_domain_name
    origin_id   = local.s3_origin_id_new
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity_new.cloudfront_access_identity_path
    }
  }
  #aliases           = ["*.dev.raintreeinc.com"]
  aliases           = ["kiosk-forms.${lower(local.local_data.tag_env)}.raintreeinc.com"]
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "${lower(local.local_data.tag_prefix)}-cloudfront-dstribution-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  default_root_object = "index.html"
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id_new
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
    target_origin_id = local.s3_origin_id_new
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
    Name        = "${lower(local.local_data.tag_prefix)}-forms-cloudfront-distribution-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
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
  domain_name_new =  aws_cloudfront_distribution.s3_distribution_new.domain_name
}

output "domain_name_new" {
  value = local.domain_name
}

data "aws_iam_policy_document" "s3_policy_new" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.scdfntnew.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity_new.iam_arn]
    }
  }
}
resource "aws_s3_bucket_policy" "scdfntnew" {
  bucket = aws_s3_bucket.scdfntnew.id
  policy = data.aws_iam_policy_document.s3_policy_new.json
}
resource "aws_s3_bucket_public_access_block" "scdfntnew" {
  bucket = aws_s3_bucket.scdfntnew.id
  block_public_acls       = true
  block_public_policy     = true
  //ignore_public_acls      = true
  //restrict_public_buckets = true
}


resource "aws_route53_record" "cdn-cname-new" {
  zone_id = "${lower(local.local_data.zone_id)}"
  name    = "kiosk-forms.${lower(local.local_data.tag_env)}.raintreeinc.com"
  type    = "CNAME"
  ttl     = "300"
  records = ["${local.domain_name}"]
}
