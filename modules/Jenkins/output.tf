output "jenkins_privateip" {
    value = aws_instance.K8_Jenkins_Server.private_ip
}

output "jenkins_id" {
    value = aws_instance.K8_Jenkins_Server.id
}