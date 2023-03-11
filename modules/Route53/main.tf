#Create hosted zone to test the created certificate 
data "aws_route53_zone" "manualhosted" {
  name         = var.domain_name
  private_zone = false
}
#Record
resource "aws_route53_record" "K8-ns" {
  zone_id = data.aws_route53_zone.manualhosted.zone_id
  name    = var.domain_name
  type    = var.rec_type

  alias {
    name                   = var.lb_dns
    zone_id                = var.lb_zoneid
    evaluate_target_health = true
  }
}