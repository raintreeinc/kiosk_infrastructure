

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
