provider "aws" {
  region  = local.local_data.aws_region
  default_tags {
    tags = {
      Environment   = local.local_data.tag_env
      Owner         = local.local_data.tag_owner
      Automation    = local.local_data.tag_automation
      SupportGroup  = local.local_data.tag_support_group
      Framework     = local.local_data.tag_framework
    }
  }
}
