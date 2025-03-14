locals {
  
  name = "${var.business-division}-${var.environment}"

  common_tags = {
    owners = var.business-division
    environment = var.environment
  }

}