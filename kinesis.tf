
# DynamoDB Tables
resource "aws_dynamodb_table" "Patients" {
  name             = "Patients"
  hash_key         = "pk"
  billing_mode     = "PAY_PER_REQUEST"

attribute {
    name = "pk"
    type = "S"
  }
}

resource "aws_dynamodb_table" "Appointments" {
  name             = "Appointments"
  hash_key         = "pk"
  billing_mode     = "PAY_PER_REQUEST"

attribute {
    name = "pk"
    type = "S"
  }
}

resource "aws_dynamodb_table" "AppointmentType" {
  name             = "AppointmentType"
  hash_key         = "pk"
  billing_mode     = "PAY_PER_REQUEST"


attribute {
    name = "pk"
    type = "S"
  }
}

resource "aws_dynamodb_table" "Contacts" {
  name             = "Contacts"
  hash_key         = "pk"
  billing_mode     = "PAY_PER_REQUEST"

attribute {
    name = "pk"
    type = "S"
  }
}

resource "aws_dynamodb_table" "CommPref" {
  name             = "CommPref"
  hash_key         = "pk"
  billing_mode     = "PAY_PER_REQUEST"

attribute {
    name = "pk"
    type = "S"
  }
}


resource "aws_dynamodb_table" "Ctype" {
  name             = "Ctype"
  hash_key         = "pk"
  billing_mode     = "PAY_PER_REQUEST"

attribute {
    name = "pk"
    type = "S"
  }
}

resource "aws_dynamodb_table" "Doctor" {
  name             = "Doctor"
  hash_key         = "pk"
  billing_mode     = "PAY_PER_REQUEST"

attribute {
    name = "pk"
    type = "S"
  }
}

resource "aws_dynamodb_table" "Insurance" {
  name             = "Insurance"
  hash_key         = "pk"
  billing_mode     = "PAY_PER_REQUEST"

attribute {
    name = "pk"
    type = "S"
  }
}

resource "aws_dynamodb_table" "Location" {
  name             = "Location"
  hash_key         = "pk"
  billing_mode     = "PAY_PER_REQUEST"

attribute {
    name = "pk"
    type = "S"
  }
}

resource "aws_dynamodb_table" "SessionContext" {
  name             = "SessionContext"
  hash_key         = "pk"
  billing_mode     = "PAY_PER_REQUEST"

attribute {
    name = "pk"
    type = "S"
  }
}

resource "aws_dynamodb_table" "TenantConfiguration" {
  name             = "TenantConfiguration"
  hash_key         = "TenantId"
  billing_mode     = "PAY_PER_REQUEST"

attribute {
    name = "TenantId"
    type = "S"
  }
}

resource "aws_dynamodb_table" "Abn" {
  name             = "Abn"
  hash_key         = "pk"
  billing_mode     = "PAY_PER_REQUEST"

attribute {
    name = "pk"
    type = "S"
  }
}

resource "aws_dynamodb_table" "Lefs" {
  name             = "Lefs"
  hash_key         = "pk"
  billing_mode     = "PAY_PER_REQUEST"

attribute {
    name = "pk"
    type = "S"
  }
}

resource "aws_dynamodb_table" "NeckDisabilityIndex" {
  name             = "NeckDisabilityIndex"
  hash_key         = "pk"
  billing_mode     = "PAY_PER_REQUEST"

attribute {
    name = "pk"
    type = "S"
  }
}

resource "aws_dynamodb_table" "Oswestry" {
  name             = "Oswestry"
  hash_key         = "pk"
  billing_mode     = "PAY_PER_REQUEST"

attribute {
    name = "pk"
    type = "S"
  }
}


resource "aws_dynamodb_table" "PainDrawing" {
  name             = "PainDrawing"
  hash_key         = "pk"
  billing_mode     = "PAY_PER_REQUEST"

attribute {
    name = "pk"
    type = "S"
  }
}

resource "aws_dynamodb_table" "PformCrels" {
  name             = "PformCrels"
  hash_key         = "pk"
  billing_mode     = "PAY_PER_REQUEST"

attribute {
    name = "pk"
    type = "S"
  }
}

resource "aws_dynamodb_table" "PformMedsp" {
  name             = "PformMedsp"
  hash_key         = "pk"
  billing_mode     = "PAY_PER_REQUEST"

attribute {
    name = "pk"
    type = "S"
  }
}

resource "aws_dynamodb_table" "Pmh" {
  name             = "Pmh"
  hash_key         = "pk"
  billing_mode     = "PAY_PER_REQUEST"

attribute {
    name = "pk"
    type = "S"
  }
}

resource "aws_dynamodb_table" "Ppmh" {
  name             = "Ppmh"
  hash_key         = "pk"
  billing_mode     = "PAY_PER_REQUEST"

attribute {
    name = "pk"
    type = "S"
  }
}

resource "aws_dynamodb_table" "QuickDash" {
  name             = "QuickDash"
  hash_key         = "pk"
  billing_mode     = "PAY_PER_REQUEST"

attribute {
    name = "pk"
    type = "S"
  }
}

resource "aws_dynamodb_table" "ClientTokens" {
  name             = "ClientTokens"
  hash_key         = "pk"
  billing_mode     = "PAY_PER_REQUEST"

attribute {
    name = "pk"
    type = "S"
  }
}

resource "aws_dynamodb_table" "ZipCode" {
  name             = "ZipCode"
  hash_key         = "pk"
  billing_mode     = "PAY_PER_REQUEST"

attribute {
    name = "pk"
    type = "S"
  }
}

resource "aws_dynamodb_table" "LocationConfiguration" {
  name             = "LocationConfiguration"
  hash_key         = "pk"
  billing_mode     = "PAY_PER_REQUEST"

attribute {
    name = "pk"
    type = "S"
  }
}

resource "aws_dynamodb_table" "Tenant" {
  name             = "Tenant"
  hash_key         = "id"
  billing_mode     = "PAY_PER_REQUEST"

attribute {
    name = "id"
    type = "S"
  }
attribute {
	name = "SubDomain"
	type = "S"
	}
attribute {
	name = "Client_Partner_pk"
	type = "S"
	}
attribute {
	name = "ClientId"
	type = "S"
	}		
attribute {
	name = "PartnerId"
	type = "S"
	}	
global_secondary_index {
	name               = "TenantBySubDomain"
	hash_key           = "SubDomain"
	projection_type    = "ALL"
	}
global_secondary_index {
	name               = "TenantByClientPartner"
	hash_key           = "Client_Partner_pk"
	projection_type    = "ALL"
	}
}


resource "aws_kinesis_stream" "Kioskstream" {
  name        = "Kiosk_Updates"
  stream_mode_details {
    stream_mode = "ON_DEMAND"
  }
}

resource "aws_dynamodb_kinesis_streaming_destination" "Patientsstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = "Patients"
}
resource "aws_dynamodb_kinesis_streaming_destination" "Appointmentsstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = "Appointments"
}
resource "aws_dynamodb_kinesis_streaming_destination" "Contactsstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = "Contacts"
}
resource "aws_dynamodb_kinesis_streaming_destination" "CommPrefstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = "CommPref"
}
resource "aws_dynamodb_kinesis_streaming_destination" "Abnstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = "Abn"
}
resource "aws_dynamodb_kinesis_streaming_destination" "Lefsstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = "Lefs"
}
resource "aws_dynamodb_kinesis_streaming_destination" "NeckDisabilityIndexstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = "NeckDisabilityIndex"
}
resource "aws_dynamodb_kinesis_streaming_destination" "Oswestrystream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = "Oswestry"
}
resource "aws_dynamodb_kinesis_streaming_destination" "PainDrawingstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = "PainDrawing"
}
resource "aws_dynamodb_kinesis_streaming_destination" "PformCrelsstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = "PformCrels"
}
resource "aws_dynamodb_kinesis_streaming_destination" "PformMedspstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = "PformMedsp"
}
resource "aws_dynamodb_kinesis_streaming_destination" "Pmhstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = "Pmh"
}
resource "aws_dynamodb_kinesis_streaming_destination" "Ppmhstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = "Ppmh"
}
resource "aws_dynamodb_kinesis_streaming_destination" "QuickDashstream" {
  stream_arn = aws_kinesis_stream.Kioskstream.arn
  table_name = "QuickDash"
}

resource "aws_lambda_event_source_mapping" "dynamodb-kinesis-stream-updates"{
   event_source_arn = aws_kinesis_stream.Kioskstream.arn
   function_name = "arn:aws:lambda:${lower(local.local_data.aws_region)}:${local.accountid}:function:${lower(local.local_data.tag_prefix)}-dynamodb-kinesis-stream-updates-${lower(local.local_data.tag_env)}-${lower(local.local_data.tag_project)}"
   starting_position = "LATEST"
 }




# IAM Role Creation

resource "aws_iam_role" "iam_for_lambda_kiosk" {
  name = "rt_iam_for_lambda_kiosk"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# IAM Policy Creation: Allow Cloudwatch Logging

resource "aws_iam_policy" "allow_logging" {
  name        = "rt_allow_logging_kiosk"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

# IAM Policy Creation: Allow Kinesis Processing

resource "aws_iam_policy" "allow_kinesis_processing" {
  name        = "rt_allow_kinesis_processing_kiosk"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kinesis:ListShards",
        "kinesis:ListStreams",
        "kinesis:*"
      ],
      "Resource": "arn:aws:kinesis:*:*:*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "stream:GetRecord",
        "stream:GetShardIterator",
        "stream:DescribeStream",
        "stream:*"
      ],
      "Resource": "arn:aws:stream:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "allow_lambda_dynamodb_Access" {
  name        = "rt_allow_lambda_dynamodb_kiosk"
  path        = "/"
  description = "IAM policy for dynamodb access from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*"
      ],
      "Resource": "arn:aws:dynamodb:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

# Attach IAM Policies to Roles

resource "aws_iam_role_policy_attachment" "rt_lambda_logs_kiosk" {
  role       = aws_iam_role.iam_for_lambda_kiosk.name
  policy_arn = aws_iam_policy.allow_logging.arn
}

resource "aws_iam_role_policy_attachment" "rt_kinesis_processing_kiosk" {
  role       = aws_iam_role.iam_for_lambda_kiosk.name
  policy_arn = aws_iam_policy.allow_kinesis_processing.arn
}


resource "aws_iam_role_policy_attachment" "rt_lambda_dynamodb_kiosk" {
  role       = aws_iam_role.iam_for_lambda_kiosk.name
  policy_arn = aws_iam_policy.allow_lambda_dynamodb_Access.arn
}
