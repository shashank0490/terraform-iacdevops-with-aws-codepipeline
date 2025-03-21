output "public_bastion_sg_group_id" {
  description = "The ID of the security group"
  value       = module.bastion-sg.security_group_id
}


output "public_bastion_sg_group_vpc_id" {
  description = "The VPC ID"
  value       = module.bastion-sg.security_group_vpc_id
}


output "public_bastion_sg_group_name" {
  description = "The name of the security group"
  value       = module.bastion-sg.security_group_name
}


output "private_sg_group_id" {
  description = "The ID of the security group"
  value       = module.private-sg.security_group_id
}


output "private_sg_group_vpc_id" {
  description = "The VPC ID"
  value       = module.private-sg.security_group_vpc_id
}


output "private_sg_group_name" {
  description = "The name of the security group"
  value       = module.private-sg.security_group_name
}
