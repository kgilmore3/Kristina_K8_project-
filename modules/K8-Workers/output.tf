output "wn_privateip" {
    value = aws_instance.K8-WN-Server.*.private_ip
}

output "WN_host_id" {
    value = aws_instance.K8-WN-Server.*.id
}