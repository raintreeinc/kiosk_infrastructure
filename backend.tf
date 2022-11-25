# DEV ENVT
#terraform {
#backend "s3" {
#bucket          = "use1-dev-devops-tfstate"
#key             = "kiosk_infrastructure/terraform.tfstate"
#region          = "us-east-1"
#dynamodb_table  = "use1-dev-devops-tfstate-lock"
#encrypt         = true
#}
#}

# SQA ENVT
    terraform {
      backend "s3" {
         bucket          = "use1-sqa-devops-tfstate"
        key             = "kiosk_infrastructure/terraform.tfstate"
        region          = "us-east-1"
        dynamodb_table  = "use1-sqa-devops-tfstate-lock"
        encrypt         = true
       }
    }

#UAT ENVT
#  terraform {
#  backend "s3" {
#    bucket          = "use1-uat-infra-tfstate"
#    key             = "kiosk_infrastructure/terraform.tfstate"
#    region          = "us-east-1"
#    dynamodb_table  = "use1-uat-infra-tfstate-lock"
#    encrypt         = true
#  }
# }
