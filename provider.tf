
provider "aws" {
  region  = var.region
  profile = "adebehe2002"

  default_tags {

    tags = local.mandatory_tag
  }
}