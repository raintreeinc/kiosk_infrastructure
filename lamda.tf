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

resource "aws_iam_policy" "policy" {
  name        = "test_policy"
  description = "policy for lambda role"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
           "sqs:*",
           "logs:*",
           "ec2:*",
           "dynamodb:*",
           "s3:*",
           "ec2:*",
           "logs:*",
           "kinesis:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.policy.arn
}



#lambda-1


#resource "aws_lambda_function" "kiosk-lambda" {
 
##   filename      = "lambda_function_payload.zip"
##   s3_bucket = "rt-s3-lambda-webapp-dev-kiosk" 
##   s3_key = "AspNetCoreFunction-CodeUri-Or-ImageUri-637952927665274965-637952927669751362.zip"
##   s3_object_version = local.s3_object_version
#  function_name = "rt-s3-eventbridge-sqs-dailybatch-process-sqa-kiosk"
#  role          = aws_iam_role.iam_for_lambda.arn
#  handler       = "DATA_MIGRATION::DATA_MIGRATION.Function::FunctionHandler"
#  timeout       = 600

#  runtime = "dotnet6"


#}



# lambda-2
#resource "aws_lambda_function" "kiosk-lambda-dev" {
##   filename      = "lambda_function_payload.zip"
#  s3_bucket = "rt-s3-lambda-webapp-dev-kiosk" 
#  s3_key = "AspNetCoreFunction-CodeUri-Or-ImageUri-637952927665274965-637952927669751362.zip"
##   s3_object_version = local.s3_object_version
#  function_name = "rt-s3-eventbridge-sqs-eventdata-process-sqa-kiosk"
##  role          = aws_iam_role.iam_for_lambda.arn
#  handler       = "DATA_MIGRATION::DATA_MIGRATION.Function::FunctionHandler"
#  timeout       = 600

#  runtime = "dotnet6"


#}
