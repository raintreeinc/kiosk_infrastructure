resource "aws_sqs_queue" "this" {
  name                      = "${lower(local.local_data.tag_prefix)}-dailybatchdata-sqs-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  tags = {
    Name                    = "${lower(local.local_data.tag_prefix)}-dailybatchdata-sqs-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  }
}
