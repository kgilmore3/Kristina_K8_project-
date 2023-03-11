output "certificate_arn" {
  value = aws_acm_certificate_validation.cert_valid.certificate_arn
}
output "domain-NS" {
    value = data.aws_route53_zone.main-domain.name_servers
}