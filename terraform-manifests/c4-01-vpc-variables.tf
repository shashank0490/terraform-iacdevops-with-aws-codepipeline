variable "vpc_name" {
  description = "vpc name"
  type = string
  default = "project1-vpc"
}

variable "vpc_cidr_block" {
  description = "vpc cidr"
  type = string
  default = "10.3.0.0/16" 
}

variable "vpc_availability_zones" {
  description = "vpc availability zones"
  type = list(string)
  default = [ "ap-south-1a", "ap-south-1b" ]
}

variable "vpc_public_subnets" {
  description = "vpc public subnets"
  type = list(string)
  default = [ "10.3.1.0/24", "10.3.2.0/24" ]
}

variable "vpc_private_subnets" {
  description = "vpc public subnets"
  type = list(string)
  default = [ "10.3.3.0/24", "10.3.4.0/24" ]
}

variable "vpc_database_subnets" {
  description = "vpc public subnets"
  type = list(string)
  default = [ "10.3.5.0/24", "10.3.6.0/24" ]
}

variable "vpc_create_database_subnet_group" {
  description = "VPC Create Database Subnet Group"
  type = bool
  default = true 
}

variable "vpc_create_database_subnet_route_table" {
  description = "VPC Create Database Subnet Route Table"
  type = bool
  default = true   
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT Gateways for Private Subnets Outbound Communication"
  type = bool
  default = true  
}

variable "vpc_single_nat_gateway" {
  description = "Enable only single NAT Gateway in one Availability Zone to save costs during our demos"
  type = bool
  default = true
}