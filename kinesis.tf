

resource "aws_kinesis_stream" "Kioskstream" {
  name        = "Kiosk_Updates"
  shard_count = 1
}

resource "aws_dynamodb_kinesis_streaming_destination" "Patientstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = aws_dynamodb_table.Patients.name
}

resource "aws_dynamodb_kinesis_streaming_destination" "Appointmentstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = aws_dynamodb_table.Appointments.name
}

resource "aws_dynamodb_kinesis_streaming_destination" "Contactstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = aws_dynamodb_table.Contacts.name
}

resource "aws_dynamodb_kinesis_streaming_destination" "CommPrefstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = aws_dynamodb_table.CommPref.name
}

resource "aws_dynamodb_kinesis_streaming_destination" "Oswestrystream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = aws_dynamodb_table.Oswestry.name
}

resource "aws_dynamodb_kinesis_streaming_destination" "NeckDisabilityIndexstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = aws_dynamodb_table.NeckDisabilityIndex.name
}

resource "aws_dynamodb_kinesis_streaming_destination" "Pmhstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = aws_dynamodb_table.Pmh.name
}

resource "aws_dynamodb_kinesis_streaming_destination" "Ppmhstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = aws_dynamodb_table.Ppmh.name
}

resource "aws_dynamodb_kinesis_streaming_destination" "Abnstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = aws_dynamodb_table.Abn.name
}

resource "aws_dynamodb_kinesis_streaming_destination" "PformMedspstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = aws_dynamodb_table.PformMedsp.name
}

resource "aws_dynamodb_kinesis_streaming_destination" "PformCrelsstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = aws_dynamodb_table.PformCrels.name
}
resource "aws_dynamodb_kinesis_streaming_destination" "QuickDashstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = aws_dynamodb_table.QuickDash.name
}
resource "aws_dynamodb_kinesis_streaming_destination" "Lefsstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = aws_dynamodb_table.Lefs.name
}
