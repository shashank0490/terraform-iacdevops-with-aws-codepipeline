module "bastion-sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.0.0"

  name = "${local.name}-bastion-sg"
  vpc_id = module.vpc.vpc_id

  ingress_rules = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  egress_rules = ["all-all"]
  tags = local.common_tags
}