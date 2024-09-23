# Assuming you have an existing key pair resource named 'aws_key_pair'
resource "aws_instance" "test_ec2" {
  ami                         = var.instance_ami
  instance_type               = "t2.micro" 
  key_name                    = var.key_pair_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true
  tags = {
    Name = "test-ec2"
  }
}