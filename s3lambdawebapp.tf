resource "aws_s3_bucket" "lambdawebapp" {
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

resource "aws_s3_bucket_acl" "lambdawebapp" {
  bucket                = aws_s3_bucket.lambdawebapp.id
  acl                   = "private"
}



resource "aws_s3_bucket_versioning" "lambdawebapp" {
  bucket = aws_s3_bucket.lambdawebapp.id
  versioning_configuration {
    status = "Enabled"
  }
}
