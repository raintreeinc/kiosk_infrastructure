locals {
#  local_data   = jsondecode(file("${path.module}/variables.tfvars.json"))
   local_data   = jsondecode(file("${path.module}/dev.tfvars.json"))
}
