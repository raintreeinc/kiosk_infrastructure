terraform {
  backend "s3" {
    bucket          = "use1-uat-devops-tfstate"
    key             = "kiosk_infrastructure/terraform.tfstate"
    region          = "us-east-1"
    dynamodb_table  = "use1-uat-devops-tfstate-lock"
    encrypt         = true
  }
}

#terraform {
#  backend "s3" {
#    bucket          = "use1-${lower(local.local_data.tag_env)}-devops-tfstate"
#    key             = "kiosk_infrastructure/terraform.tfstate"
#    region          = "${lower(local.local_data.aws_region)}"
#    dynamodb_table  = "use1-${lower(local.local_data.tag_env)}-devops-tfstate-lock"
#    encrypt         = true
#  }
#}





