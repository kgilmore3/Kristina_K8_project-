output "keypair_id" {
  value = aws_key_pair.K8_Key.id
}

output "keypair_name" {
  value = aws_key_pair.K8_Key.key_name
}
