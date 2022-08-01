resource "aws_iam_role" "iam_for_lambda" {
  name = "kiosk-rtree-lamda-role-new"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}






resource "aws_lambda_function" "kiosk-lambda" {
 
#   filename      = "lambda_function_payload.zip"
  s3_bucket = "kiosk-rtree-api-new" 
  s3_key = "AspNetCoreFunction-CodeUri-Or-ImageUri-637890741703279843-637890743207211420 (1).zip"
#   s3_object_version = local.s3_object_version
  function_name = "${lower(local.local_data.tag_prefix)}-s3-eventbridge-sqs-dailybatch-process-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.test"



  runtime = "dotnet6"


}
