module "ec2-private-app1" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.5.0"

  depends_on = [module.vpc]

  name = "${local.name}-private-app1"
  ami = data.aws_ami.amznlinux2023.id
  instance_type = var.instance_type
  vpc_security_group_ids = [module.private-sg.security_group_id]
  key_name = var.instance_keypair
  
  tags = local.common_tags

  for_each = toset(["0", "1"])
  subnet_id = element(module.vpc.public_subnets, tonumber(each.key))
  user_data = base64enccode(file("${path.module}/scripts/app1-install.sh"))

}