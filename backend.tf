terraform {
  backend "s3" {
    bucket          = "use1-dev-devops-tfstate"
    key             = "kiosk_infrastructure/terraform.tfstate"
    region          = "us-east-1"
    dynamodb_table  = "use1-uat-devops-tfstate-lock"
    encrypt         = true
  }
}

#terraform {
#  backend "s3" {
#    bucket          = "use1-uat-infra-tfstate"
#    key             = "kiosk_infrastructure/terraform.tfstate"
#    region          = "us-east-1"
#    dynamodb_table  = "use1-uat-infra-tfstate-lock"
#    encrypt         = true
#  }
#}
