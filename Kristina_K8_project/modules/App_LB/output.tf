output "lb-tg" {
  value = aws_lb_target_group.K8-lb-tg.arn
} 

output "lb_dns" {
  value = aws_lb.K8-lb.dns_name
} 

output "lb_zoneID" {
  value = aws_lb.K8-lb.zone_id
}

output "lb_arn" {
  value = aws_lb.K8-lb.arn
}