module "private-sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.0.0"

  name = "${local.name}-private-sg"
  vpc_id = module.vpc.vpc_id

  ingress_rules =  ["http-80-tcp", "https-443-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]

  ingress_with_cidr_blocks = [
    
    {
      rule        = "ssh-tcp"
      cidr_blocks = module.vpc.vpc_cidr_block
    }

  ]

  egress_rules = ["all-all"]
  tags = local.common_tags
}