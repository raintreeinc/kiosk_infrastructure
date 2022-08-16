resource "aws_api_gateway_domain_name" "example" {
  domain_name              = "rt-adminapi-dev-kiosk.dev.raintreeinc.com"
  regional_certificate_arn = "certificate arn"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}
