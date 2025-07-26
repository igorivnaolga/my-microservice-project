resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id  # Associate the route table with our VPC

  tags = {
    Name = "${var.vpc_name}-public-rt"  # Tag for the route table
  }
}

# Add a route for internet access through the Internet Gateway
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id    # Route table ID
  destination_cidr_block = "0.0.0.0/0"                  # All IP addresses
  gateway_id             = aws_internet_gateway.main.id # Specify Internet Gateway as the target
}

# Associate the route table with public subnets
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)  # Associate each subnet
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

## Create a route table for private subnets
#resource "aws_route_table" "private" {
#  vpc_id = aws_vpc.main.id
#
#  route {
#    cidr_block     = "0.0.0.0/0"
#    nat_gateway_id = aws_nat_gateway.main.id
#  }
#
#  tags = {
#    Name = "${var.vpc_name}-private-rt"
#  }
#}
#
## Associate the route table with private subnets
#resource "aws_route_table_association" "private" {
#  count          = length(var.private_subnets)
#  subnet_id      = aws_subnet.private[count.index].id
#  route_table_id = aws_route_table.private.id
#}