output "HAProxy-privateip" {
    value = aws_instance.K8_HA-Proxy-Server.private_ip
}

output "HAProxy-id" {
    value = aws_instance.K8_HA-Proxy-Server.id
}