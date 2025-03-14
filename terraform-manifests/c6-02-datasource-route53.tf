data "aws_route53_zone" "selected" {
  name         = "letsdodevops.in"
  private_zone = false
}

output "mydomain_zoneid" {
  description = "hostedzone id of desired hosted zone"
  value = data.aws_route53_zone.selected.id
}

output "mydomain_name" {
  description = " The Hosted Zone name of the desired Hosted Zone."
  value = data.aws_route53_zone.selected.name
}