resource "aws_cloudwatch_event_rule" "kiosk-event-bridge" {
  name        = "${lower(local.local_data.tag_prefix)}-dailybatchdata-sqs-ebrule-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  description = "Capture each AWS Console s3 events"

  event_pattern = <<EOF
{
  
  "source": ["aws.s3"],
  "detail": {
    "bucket": {
      "name": ["rt-s3-raintree-eventdata-sqa-kiosk"]
    }
  }

}
EOF
}


resource "aws_cloudwatch_event_target" "sqs" {
  rule      = aws_cloudwatch_event_rule.kiosk-event-bridge.name
  target_id = "SendToSQS"
  arn       = aws_sqs_queue.this.arn
}


# resource "aws_lambda_event_source_mapping" "event_source_mapping" {
#   batch_size        = 1
#   event_source_arn  = aws_sqs_queue.my_queue.arn
#   enabled           = true
#   function_name     = aws_lambda_function.my_lambda.arn
# }
