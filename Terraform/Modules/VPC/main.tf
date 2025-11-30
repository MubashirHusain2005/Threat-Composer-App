  resource "aws_vpc" "main-vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "Main-VPC"
  }
}

  resource "aws_subnet" "public" {
    for_each = var.public_subnets
    vpc_id     = aws_vpc.main-vpc.id
    cidr_block = each.value.cidr
    availability_zone = each.value.az
    map_public_ip_on_launch = var.public_ip

    tags = {
      Name = each.key
    }

  }



resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main-vpc.id

  tags = {
    Name = "Main-IGW"
  }
}



resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }

  tags = {
    Name = "Route Table"
  }
}


resource "aws_route_table_association" "public-assoc" {
  for_each = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public-rt.id
}






 


