 resource "aws_s3_bucket" "event" {
  bucket        = "${lower(local.local_data.tag_prefix)}-raintree-eventdata-s3-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  tags = {
    Name        = "${lower(local.local_data.tag_prefix)}-raintree-eventdata-s3-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
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

resource "aws_s3_bucket_notification" "eventnotification" {
  bucket                = aws_s3_bucket.event.id
  eventbridge           = true
}



resource "aws_s3_bucket_versioning" "event" {
  bucket = aws_s3_bucket.event.id
  versioning_configuration {
    status = "Enabled"
  }
}



resource "aws_cloudwatch_event_rule" "kiosk-event-bridge-event" {
  name        = "${lower(local.local_data.tag_prefix)}-eventdata-sqs-ebrule-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  description = "Capture each AWS Console s3 events"

  event_pattern = <<EOF
{
  
  "source": ["aws.s3"],
  "detail-type": ["Object Created"],
  "detail": {
    "bucket": {
      "name": ["${lower(local.local_data.tag_prefix)}-raintree-eventdata-s3-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"]
    }
  }
}
EOF
}


resource "aws_cloudwatch_event_target" "sqs" {
  rule      = aws_cloudwatch_event_rule.kiosk-event-bridge-event.name
  target_id = "SendToSQS"
  arn       = aws_sqs_queue.event.arn
}



resource "aws_sqs_queue" "event" {
  name                      = "${lower(local.local_data.tag_prefix)}-eventdata-sqs-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  delay_seconds             = 6
  max_message_size          = 262144
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  visibility_timeout_seconds = 600
  tags = {
    Name                    = "${lower(local.local_data.tag_prefix)}-eventdata-sqs-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  }
}

resource "aws_sqs_queue_policy" "event_sqs_policy" {
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
      "Resource": "${aws_sqs_queue.event.arn}"
    }
  ]
}
POLICY
}


data "aws_caller_identity" "current" {}

locals {
    account_id = data.aws_caller_identity.current.account_id
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

resource "aws_lambda_event_source_mapping" "kiosk-sqs-lambdamapping"{
   event_source_arn = aws_sqs_queue.event.arn 
#   function_name = aws_lambda_function.kiosk-lambda-dev.arn
   function_name = "arn:aws:lambda:${lower(local.local_data.aws_region)}:${local.account_id}:function:${lower(local.local_data.tag_prefix)}-s3-eventbridge-sqs-event-process-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
   
   }
