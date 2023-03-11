output "ansible_privateip" {
    value = aws_instance.K8_Ansible-Server.private_ip
}

output "ansible_id" {
    value = aws_instance.K8_Ansible-Server.id
}