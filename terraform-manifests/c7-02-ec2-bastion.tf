module "ec2-bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.5.0"

  name = "${local.name}-bastionhost"
  ami = data.aws_ami.amznlinux2023.id
  instance_type = var.instance_type
  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.bastion-sg.security_group_id]
  key_name = var.instance_keypair
  tags = local.common_tags
}