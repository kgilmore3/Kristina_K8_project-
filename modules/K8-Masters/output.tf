output "mn_privateip" {
    value = aws_instance.K8-MN-Server.*.private_ip
}

output "mn_host_id" {
    value = aws_instance.K8-MN-Server.*.id
}