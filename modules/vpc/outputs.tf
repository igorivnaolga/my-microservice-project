output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "internet_gateway_id" {
  description = "ID Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "vpc_cidr_block" {
  value = aws_vpc.main.cidr_block
}

#output "nat_gateway_id" {
#  description = "ID NAT-інстансу"
#  value       = aws_nat_gateway.main.id
#}
