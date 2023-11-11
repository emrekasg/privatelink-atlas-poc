resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/20"
  instance_tenancy = "default"

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "mongodb-privatelink-poc"
  }

}
resource "aws_subnet" "private" {
  count                   = 3
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 4, count.index)
  availability_zone       = element(var.vpc_azs, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "mongodb-privatelink-poc-private-${count.index}"
  }
}

resource "aws_subnet" "public" {
  count                   = 3
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 4, count.index + 4)
  availability_zone       = element(var.vpc_azs, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "mongodb-privatelink-poc-public-${count.index}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "mongodb-privatelink-poc-igw"
  }
}

resource "aws_eip" "natgw" {
  count = 1

  tags = {
    Name = "mongodb-privatelink-poc-natgw"
  }
}

resource "aws_nat_gateway" "natgw" {
  count         = 1
  allocation_id = aws_eip.natgw[0].id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "mongodb-privatelink-poc-natgw"
  }

  depends_on = [
    aws_internet_gateway.igw
  ]
}


