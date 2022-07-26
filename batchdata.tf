resource "aws_s3_bucket" "batch" {
  bucket        = "${lower(local.local_data.tag_prefix)}-raintree-batchdata-s3-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  tags = {
    Name        = "${lower(local.local_data.tag_prefix)}-raintree-batchdata-s3-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  }
  force_destroy = true
  lifecycle {
    ignore_changes = [
      server_side_encryption_configuration
    ]
  }
}

resource "aws_s3_bucket_acl" "batch" {
  bucket                = aws_s3_bucket.batch.id
  acl                   = "private"
}

resource "aws_s3_bucket_notification" "batchnotification" {
  bucket                = aws_s3_bucket.batch.id
  eventbridge           = true
}

# resource "aws_s3_bucket_server_side_encryption_configuration" "batch" {
#   bucket                = aws_s3_bucket.batch.bucket
#   rule {
#     apply_server_side_encryption_by_default {
#       kms_master_key_id = data.aws_kms_key.batch.id
#       sse_algorithm     = "aws:kms"
#     }
#   }
# }

#resource "aws_s3_bucket_versioning" "batch" {
#  bucket = aws_s3_bucket.batch.id
#  versioning_configuration {
#    status = "Enabled"
#  }
#}


resource "aws_cloudwatch_event_rule" "kiosk-event-bridge-batch" {
  name        = "${lower(local.local_data.tag_prefix)}-dailybatchdata-sqs-ebrule-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  description = "Capture each AWS Console s3 events"

  event_pattern = <<EOF
{
  
  "source": ["aws.s3"],
  "detail-type": ["Object Created"],
  "detail": {
    "bucket": {
      "name": ["${lower(local.local_data.tag_prefix)}-raintree-batchdata-s3-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"]
    }
  }
}
EOF
}


resource "aws_cloudwatch_event_target" "batch" {
  rule      = aws_cloudwatch_event_rule.kiosk-event-bridge-batch.name
  target_id = "SendToSQS"
  arn       = aws_sqs_queue.batch.arn
}


resource "aws_sqs_queue" "batch" {
  name                      = "${lower(local.local_data.tag_prefix)}-batchdata-sqs-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  delay_seconds             = 5
  max_message_size          = 262144
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  visibility_timeout_seconds = 600

  
}

resource "aws_sqs_queue_policy" "test_sqs_policy" {
  queue_url = aws_sqs_queue.batch.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:*",
      "Resource": "${aws_sqs_queue.batch.arn}"
    }
  ]
}
POLICY
}

data "aws_caller_identity" "currentid" {}

locals {
    accountid = data.aws_caller_identity.currentid.account_id
}

output "accountid" {
  value = data.aws_caller_identity.currentid.account_id
}

resource "aws_lambda_event_source_mapping" "kiosk-sqs-lambdamapping-dev"{
   event_source_arn = aws_sqs_queue.batch.arn 
#   function_name = aws_lambda_function.kiosk-lambda.arn
  function_name = "arn:aws:lambda:${lower(local.local_data.aws_region)}:${local.accountid}:function:${lower(local.local_data.tag_prefix)}-s3-eventbridge-sqs-dailybatch-process-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
   
 }
