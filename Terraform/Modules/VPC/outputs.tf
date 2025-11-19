output "public_subnet_ids" {
    description = "List of public IDs"
    value       = [aws_subnet.Subnet-2a.id, aws_subnet.Subnet-2b.id]
}

output "vpc_id" {
    value = aws_vpc.Main.id
}
