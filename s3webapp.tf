 resource "aws_s3_bucket" "event" {
  bucket        = "${lower(local.local_data.tag_prefix)}-s3-webappassets-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  tags = {
    Name        = "${lower(local.local_data.tag_prefix)}-s3-webappassets-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  }
  lifecycle {
    ignore_changes = [
      server_side_encryption_configuration
    ]
  }
}

resource "aws_s3_bucket_acl" "event" {
  bucket                = aws_s3_bucket.event.id
  acl                   = "private"
}



resource "aws_s3_bucket_versioning" "event" {
  bucket = aws_s3_bucket.event.id
  versioning_configuration {
    status = "Enabled"
  }
}
