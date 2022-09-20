

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

