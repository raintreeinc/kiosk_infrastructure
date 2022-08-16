resource "aws_api_gateway_domain_name" "example" {
  domain_name              = "rt-adminapi-dev-kiosk.dev.raintreeinc.com"
  regional_certificate_arn = "809e311a-024e-4c98-bc72-3ae368a577af"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}
