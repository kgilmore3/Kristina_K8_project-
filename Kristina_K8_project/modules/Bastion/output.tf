output "Bastion_publicip" {
    value = aws_instance.K8-Bastion.public_ip
  
}