locals {
  deployment_id = lower("${var.deployment_name}_${random_string.suffix.result}")
}

# Common random string 8 characters long
resource "random_string" "suffix" {
  length  = 8
  special = false
}

# RSA key of size 4096 bits
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Save the private key to a file
resource "local_file" "private_key" {
  content  = tls_private_key.ssh.private_key_pem
  filename = "${path.module}/generated/${local.deployment_id}_key.pem"

  provisioner "local-exec" {
    command = "chmod 400 ${path.module}/generated/${local.deployment_id}_key.pem"
  }
}

# AWS key pair
resource "aws_key_pair" "aws_key_pair" {
  key_name   = "${local.deployment_id}_key"
  public_key = tls_private_key.ssh.public_key_openssh

  tags = merge(
    { Name = var.ec2_ssh_keypair_name },
    var.common_tags
  )

}