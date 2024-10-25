provider "tls" {}

# Generate an RSA private key
resource "tls_private_key" "haproxy_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Create a self-signed certificate
resource "tls_self_signed_cert" "haproxy_cert" {
  subject {
    common_name = "localhost1"
  }
  validity_period_hours = 365 * 24
  allowed_uses          = ["key_encipherment", "digital_signature", "server_auth"]

  private_key_pem = tls_private_key.haproxy_key.private_key_pem
}

# Save the key and certificate to individual files
resource "local_file" "haproxy_key" {
  content  = tls_private_key.haproxy_key.private_key_pem
  filename = "${path.module}/haproxy/haproxy.key"
}

resource "local_file" "haproxy_cert" {
  content  = tls_self_signed_cert.haproxy_cert.cert_pem
  filename = "${path.module}/haproxy/haproxy.crt"
}

# Combine the key and certificate into a .pem file
resource "local_file" "haproxy_pem" {
  content  = <<-EOT
    ${tls_self_signed_cert.haproxy_cert.cert_pem}
    ${tls_private_key.haproxy_key.private_key_pem}
    EOT
  filename = "${path.module}/haproxy/haproxy.pem"
}

