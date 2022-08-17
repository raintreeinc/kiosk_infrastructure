resource "aws_api_gateway_domain_name" "adminapigateway" {
#  domain_name              = "rt-adminapi-kiosk.dev.raintreeinc.com"
  domain_name              = "rt-adminapi-kiosk.sqa.raintreeinc.com"
#  regional_certificate_arn = "arn:aws:acm:us-east-1:106367354196:certificate/809e311a-024e-4c98-bc72-3ae368a577af"
  regional_certificate_arn  = "arn:aws:acm:us-east-1:120192477360:certificate/a35f41e2-01d9-4f52-8b66-16215db7c047"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_domain_name" "kioskapigateway" {
#  domain_name              = "rt-api-kiosk.dev.raintreeinc.com"
  domain_name              = "rt-api-kiosk.sqa.raintreeinc.com"
#  regional_certificate_arn = "arn:aws:acm:us-east-1:106367354196:certificate/809e311a-024e-4c98-bc72-3ae368a577af"
  regional_certificate_arn  = "arn:aws:acm:us-east-1:120192477360:certificate/a35f41e2-01d9-4f52-8b66-16215db7c047"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}



resource "aws_api_gateway_base_path_mapping" "backend" {
  api_id      = "rt-s3-lambda-webapp-batch-sqa-kiosk"
  domain_name = aws_api_gateway_domain_name.adminapigateway.id
  stage_name = "dev"
}
