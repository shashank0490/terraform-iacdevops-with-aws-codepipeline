variable "region" {
  description = "default terraform region"
  type = string
  default = "ap-south-1"
}

variable "environment" {
  description = "terraform environment"
  type = string
  default = "dev"
}

variable "business-division" {
  description = "business division"
  type = string
  default = "devops"
}

