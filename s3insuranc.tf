 resource "aws_s3_bucket" "insuranc" {
  bucket        = "${lower(local.local_data.tag_prefix)}-s3-insurancedata-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  tags = {
    Name        = "${lower(local.local_data.tag_prefix)}-s3-insurancedata-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  }
  lifecycle {
    ignore_changes = [
      server_side_encryption_configuration
    ]
  }
}

resource "aws_s3_bucket_acl" "insuranc" {
  bucket                = aws_s3_bucket.insuranc.id
  acl                   = "private"
}



resource "aws_s3_bucket_versioning" "insuranc" {
  bucket = aws_s3_bucket.insuranc.id
  versioning_configuration {
    status = "Enabled"
  }
}
