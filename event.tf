 resource "aws_s3_bucket" "event" {
  bucket        = "${lower(local.local_data.tag_prefix)}-s3-raintree-eventdata-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  tags = {
    Name        = "${lower(local.local_data.tag_prefix)}-s3-raintree-eventdata-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
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


resource "aws_cloudwatch_event_rule" "kiosk-event-bridge-event" {
  name        = "${lower(local.local_data.tag_prefix)}-eventdata-sqs-ebrule-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  description = "Capture each AWS Console s3 events"

  event_pattern = <<EOF
{
  
  "source": ["aws.s3"],
  "detail-type": ["Object Created"],
  "detail": {
    "bucket": {
      "name": ["rt-s3-raintree-eventdata-sqa-kiosk"]
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
  delay_seconds             = 90
  max_message_size          = 1026
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  tags = {
    Name                    = "${lower(local.local_data.tag_prefix)}-eventdata-sqs-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  }
}


resource "aws_lambda_event_source_mapping" "kiosk-sqs-lambdamapping"{
   event_source_arn = aws_sqs_queue.event.arn 
   function_name = aws_lambda_function.kiosk-lambda-dev.arn
   
   }
