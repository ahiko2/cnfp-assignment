resource "aws_vpc" "terraform_vpc" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "terraform-test-vpc"
  }
}

# Create Subnet 1
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "192.168.0.0/20"
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "terraform-test-vpc-subnet1"
  }
}

# Create Subnet 2
resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "192.168.16.0/20"
  availability_zone = "ap-northeast-1c"
  tags = {
    Name = "terraform-test-vpc-subnet2"
  }
}
