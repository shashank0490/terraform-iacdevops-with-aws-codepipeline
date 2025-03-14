module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "5.0.0"

  validation_method = "DNS"

  domain_name = trimsuffix(data.aws_route53_zone.selected.name, ".")
  zone_id     = data.aws_route53_zone.selected.id

  subject_alternative_names = [
    #  "*.letsdodevops.in"
    var.dns_name
  ]

  tags = local.common_tags

}

output "acm_certificate_arn" {
  description = "The ARN of the certificate"
  value       = module.acm.acm_certificate_arn
}