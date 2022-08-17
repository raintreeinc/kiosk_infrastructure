resource "aws_s3_bucket" "webapp" {
  bucket        = "${lower(local.local_data.tag_prefix)}-lambda-webapp-s3-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  tags = {
    Name        = "${lower(local.local_data.tag_prefix)}-lambda-webapp-s3-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  }
  lifecycle {
    ignore_changes = [
      server_side_encryption_configuration
    ]
  }
}

resource "aws_s3_bucket_acl" "webapp" {
  bucket                = aws_s3_bucket.webapp.id
  acl                   = "private"
}



resource "aws_s3_bucket_versioning" "webapp" {
  bucket = aws_s3_bucket.webapp.id
  versioning_configuration {
    status = "Enabled"
  }
}
