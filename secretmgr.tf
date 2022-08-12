resource "aws_secretsmanager_secret" "secretClientConfig" {
   name = "rt-client-configs"
}
 
# Creating a AWS secret versions for database master account (Masteraccoundb)
 
resource "aws_secretsmanager_secret_version" "sversion" {
  secret_id = aws_secretsmanager_secret.secretClientConfig.id
  secret_string = <<EOF
   {
    "c0a6a6a6a6a6#dat#appid": "EaXLDE-vp3tbrxW-6Kdn4-G3okFg",
    "c0a6a6a6a6a6#dat#clientsecret": "e38929b2b66d097f7c8f20eb4afb2532",
    "c0a6a6a6a6a6#dat#clientId": "b4d8f090ca84182709ed50cc"
   }
EOF
}


resource "aws_iam_policy" "secretmanagerpolicy" {
  name        = "rt-secretmanager-read-kiosk"
  path        = "/"
  description = "Policy to allow access to Secrets manager"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "secretsmanager: *",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
