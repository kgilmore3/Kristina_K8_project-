output "ansible-sg-id" {
  value = aws_security_group.K8_Ansible_SG.id
}

output "jenkins-sg-id" {
  value = aws_security_group.K8_Jenkins_SG.id
}

output "alb-sg-id" {
  value = aws_security_group.K8_ALB_SG.id
}

output "bastion-sg-id" {
  value = aws_security_group.K8_bastion_SG.id
}

output "mast-wor-sg-id" {
  value = aws_security_group.K8_Mast_Wor_SG.id
}

