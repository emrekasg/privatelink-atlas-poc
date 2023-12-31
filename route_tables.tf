resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "privatelink-poc-public-rt"
  }
}

resource "aws_route_table_association" "public_rt_association" {
  count          = 3
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_rt.id
}


resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    // all private subnets will use the same NAT gateway
    nat_gateway_id = aws_nat_gateway.natgw[0].id
  }

  tags = {
    Name = "privatelink-poc-private-rt"
  }
}

resource "aws_route_table_association" "private_rt_association" {
  count          = 3
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_rt.id
}

