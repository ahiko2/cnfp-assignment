output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "subnet_id" {
  value = aws_subnet.subnet1.id
}

output "security_group_id" {
  value = aws_security_group.elli-vpc-sg.id
}