resource "aws_s3_bucket" "this" {
  bucket        = "${lower(local.local_data.tag_prefix)}-frontend-webapp-s3-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  tags = {
    Name        = "${lower(local.local_data.tag_prefix)}-frontend-webapp-s3-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  }
  lifecycle {
    ignore_changes = [
      server_side_encryption_configuration
    ]
  }
}

resource "aws_s3_bucket_acl" "this" {
  bucket                = aws_s3_bucket.this.id
  acl                   = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket                = aws_s3_bucket.this.bucket
  rule {
    apply_server_side_encryption_by_default {
#      kms_master_key_id = data.aws_kms_key.this.id
       sse_algorithm     = "AES256"
        
    }
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket

  index_document {
    suffix = "index.html"
  }
}

 
