output "deployment_id" {
  value = local.deployment_id
}
output "ssh_private_key" {
  value     = tls_private_key.ssh.private_key_pem
  sensitive = true
}
output "ssh_public_key" {
  value = aws_key_pair.aws_key_pair.public_key

}
output "aws_key_pair_name" {
  value = aws_key_pair.aws_key_pair.key_name
}