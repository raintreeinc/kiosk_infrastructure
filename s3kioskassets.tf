 resource "aws_s3_bucket" "asset" {
  bucket        = "${lower(local.local_data.tag_prefix)}-s3-asset-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  tags = {
    Name        = "${lower(local.local_data.tag_prefix)}-s3-asset-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  }
  lifecycle {
    ignore_changes = [
      server_side_encryption_configuration
    ]
  }
}

resource "aws_s3_bucket_acl" "asset" {
  bucket                = aws_s3_bucket.asset.id
  acl                   = "private"
}



resource "aws_s3_bucket_versioning" "asset" {
  bucket = aws_s3_bucket.asset.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_cors_configuration" "assets3cors" {
  bucket = aws_s3_bucket.asset.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "GET", "DELETE"]
    allowed_origins = ["*"]
    expose_headers  = []
    max_age_seconds = 3000
  }

}

resource "aws_s3_bucket_policy" "allow_access" {
  bucket = aws_s3_bucket.example.id
  policy = data.aws_iam_policy_document.allow_access.json
}

data "aws_iam_policy_document" "allow_access" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.asset.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = "*"
    }
  }
}
