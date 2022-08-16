resource "aws_api_gateway_domain_name" "adminapigateway" {
  domain_name              = "rt-adminapi-dev-kiosk.dev.raintreeinc.com"
  regional_certificate_arn = "arn:aws:acm:us-east-1:106367354196:certificate/809e311a-024e-4c98-bc72-3ae368a577af"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_domain_name" "kioskapigateway" {
  domain_name              = "rt-api-dev-kiosk.dev.raintreeinc.com"
  regional_certificate_arn = "arn:aws:acm:us-east-1:106367354196:certificate/809e311a-024e-4c98-bc72-3ae368a577af"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}
