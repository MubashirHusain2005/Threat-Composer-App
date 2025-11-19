#VPC
  resource "aws_vpc" "Main" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

#Public Subnets
  resource "aws_subnet" "Subnet-2a" {
  vpc_id     = aws_vpc.Main.id
  cidr_block = var.public_subnet_cidrs[0]
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet-2a"
  }
}

resource "aws_subnet" "Subnet-2b" {
  vpc_id     = aws_vpc.Main.id
  cidr_block = var.public_subnet_cidrs[1]
  availability_zone = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet-2b"
  }
}

#Internet Gateway

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.Main.id

  tags = {
    Name = "Main-IGW"
  }
}

#Public Route Table

resource "aws_route_table" "Public-RT" {
  vpc_id = aws_vpc.Main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = "Route Table"
  }
}

#Route Table Associations

resource "aws_route_table_association" "public-subnet-2a" {
  subnet_id      = aws_subnet.Subnet-2a.id
  route_table_id = aws_route_table.Public-RT.id
}

resource "aws_route_table_association" "public-subnet-2b" {
  subnet_id      = aws_subnet.Subnet-2b.id
  route_table_id = aws_route_table.Public-RT.id
}






 


