output "nameservers" {
  value = data.aws_route53_zone.manualhosted.name_servers
}