# Environment
environment = "stag"
# VPC Variables
vpc_name = "myvpc"
vpc_cidr_block = "10.4.0.0/16"
vpc_availability_zones = ["ap-south-1a", "ap-south-1b"]
vpc_public_subnets = ["10.4.101.0/24", "10.4.102.0/24"]
vpc_private_subnets = ["10.4.1.0/24", "10.4.2.0/24"]
vpc_database_subnets= ["10.4.151.0/24", "10.4.152.0/24"]
vpc_create_database_subnet_group = true 
vpc_create_database_subnet_route_table = true   
vpc_enable_nat_gateway = true  
vpc_single_nat_gateway = true

# EC2 Instance Variables
instance_type = "t2.micro"
instance_keypair = "terraform-key"
private_instance_count = 2

# DNS Name
dns_name = "stagedemo5.letsdodevops.in"
