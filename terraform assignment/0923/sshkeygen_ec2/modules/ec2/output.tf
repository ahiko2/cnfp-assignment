output "instance" {
  value = aws_instance.test_ec2
}

output "instance_ip" {
  value = aws_instance.test_ec2.public_ip
}