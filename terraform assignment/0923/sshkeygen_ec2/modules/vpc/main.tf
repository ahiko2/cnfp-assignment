resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_primary_cidr
  tags = {
    Name = "elli-vpc"
  }
}

# Create Subnet 1
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.subnet_cidr_block_public_1a
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "elli-vpc-subnet1"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "elli-vpc-igw"
  }
}

# Route Table for public subnets (allowing internet access)
resource "aws_route_table" "test_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id 

  }
  tags = {
    Name = "elli-vpc-public-rt" 

  }
}

# Associate Subnet 1 with the public route table
resource "aws_route_table_association" "public_subnet_1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.test_route_table.id
}

# Security Group to control inbound/outbound traffic (adjust rules as needed)
resource "aws_security_group" "elli-vpc-sg" {
  name        = "elli-vpc-sg"
  description = "Allow All traffic"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}