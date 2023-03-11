resource "aws_acm_certificate" "certif" {
  domain_name               = "kristinamarieonline.com"
  subject_alternative_names = ["www.kristinamarieonline.com"]
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "main-domain" {
  name         = "kristinamarieonline.com"
  private_zone = false
}

resource "aws_route53_record" "route53record" {
  for_each = {
    for dvo in aws_acm_certificate.certif.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      record  = dvo.resource_record_value
      type    = dvo.resource_record_type
      zone_id = dvo.domain_name == "kristinamarieonline.com" ? data.aws_route53_zone.main-domain.zone_id : data.aws_route53_zone.main-domain.zone_id
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = each.value.zone_id
}

resource "aws_acm_certificate_validation" "cert_valid" {
  certificate_arn         = aws_acm_certificate.certif.arn
  validation_record_fqdns = [for record in aws_route53_record.route53record : record.fqdn]
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = var.lb_arn
  port              = var.secureport
  protocol          = var.protocol
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate_validation.cert_valid.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = var.lb_target_arn
  }
}
