# resource "aws_s3_bucket" "batch" {
#   bucket        = "${lower(local.local_data.tag_prefix)}-s3-raintree-batchdata-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
#   tags = {
#     Name        = "${lower(local.local_data.tag_prefix)}-s3-raintree-batchdata-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
#   }
#   lifecycle {
#     ignore_changes = [
#       server_side_encryption_configuration
#     ]
#   }
# }

# resource "aws_s3_bucket_acl" "batch" {
#   bucket                = aws_s3_bucket.batch.id
#   acl                   = "private"
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "batch" {
#   bucket                = aws_s3_bucket.batch.bucket
#   rule {
#     apply_server_side_encryption_by_default {
#       kms_master_key_id = data.aws_kms_key.batch.id
#       sse_algorithm     = "aws:kms"
#     }
#   }
# }

# resource "aws_s3_bucket_versioning" "batch" {
#   bucket = aws_s3_bucket.batch.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }


# resource "aws_cloudwatch_event_rule" "kiosk-event-bridge-batch" {
#   name        = "${lower(local.local_data.tag_prefix)}-dailybatchdata-sqs-ebrule-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
#   description = "Capture each AWS Console s3 events"

#   event_pattern = <<EOF
# {
  
#   "source": ["aws.s3"],
#   "detail-type": ["Object Created"],
#   "detail": {
#     "bucket": {
#       "name": ["rt-s3-raintree-batchdata-sqa-kiosk"]
#     }
#   }
# }
# EOF
# }


# resource "aws_cloudwatch_event_target" "batch" {
#   rule      = aws_cloudwatch_event_rule.kiosk-event-bridge-batch.name
#   target_id = "SendToSQS"
#   arn       = aws_sqs_queue.batch.arn
# }


resource "aws_sqs_queue" "batch" {
  name                      = "${lower(local.local_data.tag_prefix)}-batchdata-sqs-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
  delay_seconds             = 90
  max_message_size          = 1025
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10

  tags = {
    Environment = var.Environment
  }
}
