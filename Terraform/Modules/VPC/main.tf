  resource "aws_vpc" "Main" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "Main-VPC"
  }
}


  resource "aws_subnet" "Subnet-2a" {
  vpc_id     = var.vpc_id
  cidr_block = var.public_subnet_cidrs[0]
  availability_zone = var.subnet2a
  map_public_ip_on_launch = var.public_ip

  tags = {
    Name = "Subnet-2a"
  }
}

resource "aws_subnet" "Subnet-2b" {
  vpc_id     = var.vpc_id
  cidr_block = var.public_subnet_cidrs[1]
  availability_zone = var.subnet2b
  map_public_ip_on_launch = var.public_ip

  tags = {
    Name = "Subnet-2b"
  }
}



resource "aws_internet_gateway" "IGW" {
  vpc_id = var.vpc_id

  tags = {
    Name = "Main-IGW"
  }
}



resource "aws_route_table" "Public-RT" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }

  tags = {
    Name = "Route Table"
  }
}


resource "aws_route_table_association" "public-subnet-2a" {
  subnet_id      = aws_subnet.Subnet-2a.id
  route_table_id = aws_route_table.Public-RT.id
}

resource "aws_route_table_association" "public-subnet-2b" {
  subnet_id      = aws_subnet.Subnet-2b.id
  route_table_id = aws_route_table.Public-RT.id
}






 


