output "public_subnet_ids" {
    description = "List of public IDs"
    value = {
        for key, subnet in aws_subnet.public : key => subnet.id
    }
}

output "vpc_id" {
    value = aws_vpc.main-vpc.id
    description = "VPC ID"
}
