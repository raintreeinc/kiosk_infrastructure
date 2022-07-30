resource "aws_sqs_queue" "this" {
  name                      = "${lower(local.local_data.tag_prefix)}-dailybatchdata-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  tags = {
    Name                    = "${lower(local.local_data.tag_prefix)}-dailybatchdata-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  }
}




resource "aws_cloudwatch_event_rule" "kiosk-event-bridge" {
  name        = "${lower(local.local_data.tag_prefix)}-dailybatchdata-s3-sqs-ebrule-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"

  description = "Capture each AWS Console s3 events"

  event_pattern = <<EOF
{
  
  "source": ["aws.s3"],
  "detail": {
    "bucket": {
      "name": "${lower(local.local_data.tag_prefix)}-eventdata-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
    }
  }
}
EOF
}


resource "aws_cloudwatch_event_target" "sqs" {
  rule      = aws_cloudwatch_event_rule.this.name
  target_id = "SendToSQS"
  arn       = aws_sqs_queue.this.arn
}
