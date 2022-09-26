

# s3 varibles #


variable "s3-name" {
  type = string
  default = "rt-s3-raintree-eventdata-sqa-kiosk"
#  default = "rt-s3-raintree-eventdata-uat-kiosk"
  
}

variable "Environment" {
  type = string
  default = "sqa"
#  default = "uat"
}

variable "status" {
  type = string
  default = "Enabled"
  
}


#sqs queue

variable "sqs-queue" {

  type = string
  default = "rt-dailybatchdata-sqs-sqa-kiosk"
#  default = "rt-dailybatchdata-sqs-uat-kiosk"
  
}
