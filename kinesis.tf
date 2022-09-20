

resource "aws_kinesis_stream" "Kioskstream" {
  name        = "Kiosk_Updates"
  stream_mode_details {
    stream_mode = "ON_DEMAND"
  }
}

resource "aws_dynamodb_kinesis_streaming_destination" "Patientstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = "Patients"
}

resource "aws_lambda_event_source_mapping" "kiosk-sqs-lambdamapping-dev"{
   event_source_arn = aws_kinesis_stream.Kioskstream.arn
   function_name = "arn:aws:lambda:${lower(local.local_data.aws_region)}:${local.accountid}:function:${lower(local.local_data.tag_prefix)}-dynamodb-kinesis-stream-updates-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
   
 }


# IAM Role Creation

resource "aws_iam_role" "iam_for_lambda" {
  name = "rt_iam_for_lambda_kiosk"

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

# IAM Policy Creation: Allow Cloudwatch Logging

resource "aws_iam_policy" "allow_logging" {
  name        = "rt_allow_logging_kiosk"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

# IAM Policy Creation: Allow Kinesis Processing

resource "aws_iam_policy" "allow_kinesis_processing" {
  name        = "rt_allow_kinesis_processing_kiosk"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kinesis:ListShards",
        "kinesis:ListStreams",
        "kinesis:*"
      ],
      "Resource": "arn:aws:kinesis:*:*:*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "stream:GetRecord",
        "stream:GetShardIterator",
        "stream:DescribeStream",
        "stream:*"
      ],
      "Resource": "arn:aws:stream:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

# Attach IAM Policies to Roles

resource "aws_iam_role_policy_attachment" "rt_lambda_logs_kiosk" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.allow_logging.arn
}

resource "aws_iam_role_policy_attachment" "rt_kinesis_processing_kiosk" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.allow_kinesis_processing.arn
}
