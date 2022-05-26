# Creating a VPC for a project

resource "aws_vpc" "rock-project" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "rock-project"
  }
}

# Creating two public subnets for the aws_vpc

resource "aws_subnet" "prod-pub-sub1" {
  vpc_id            = aws_vpc.rock-project.id
  cidr_block        = var.pub-cidr1
  availability_zone = var.abz-1
  tags = {
    Name = "prod-public-sub1"
  }
}
resource "aws_subnet" "prod-pub-sub2" {
  vpc_id            = aws_vpc.rock-project.id
  cidr_block        = var.pub-cidr2
  availability_zone = var.abz-2

  tags = {
    Name = "prod-public-sub2"
  }
}

resource "aws_subnet" "prod-pub-sub3" {
  vpc_id            = aws_vpc.rock-project.id
  cidr_block        = var.pub-cidr3
  availability_zone = var.abz-3

  tags = {
    Name = "prod-public-sub3"
  }
}

# Creating two Private Subnets for the aws_vpc

resource "aws_subnet" "prod-priv-sub1" {
  vpc_id            = aws_vpc.rock-project.id
  cidr_block        = var.priv-cidr1
  availability_zone = var.abz-1

  tags = {
    Name = "prod-priv-sub1"
  }
}

resource "aws_subnet" "prod-priv-sub2" {
  vpc_id            = aws_vpc.rock-project.id
  cidr_block        = var.priv-cidr2
  availability_zone = var.abz-2

  tags = {
    Name = "prod-priv-sub2"
  }
}

# Creating two route tables,one public and the other private

resource "aws_route_table" "prod-pub-route-table" {
  vpc_id = aws_vpc.rock-project.id

  tags = {
    Name = "prod-pub-route-table"
  }
}

resource "aws_route_table" "prod-priv-route-table" {
  vpc_id = aws_vpc.rock-project.id

  tags = {
    Name = "prod-priv-route"
  }
}

# Associating subnets to the routes

resource "aws_route_table_association" "public-association1" {
  subnet_id      = aws_subnet.prod-pub-sub1.id
  route_table_id = aws_route_table.prod-pub-route-table.id
}

resource "aws_route_table_association" "public-association2" {
  subnet_id      = aws_subnet.prod-pub-sub2.id
  route_table_id = aws_route_table.prod-pub-route-table.id
}

resource "aws_route_table_association" "public-association3" {
  subnet_id      = aws_subnet.prod-pub-sub3.id
  route_table_id = aws_route_table.prod-pub-route-table.id
}

resource "aws_route_table_association" "private-association1" {
  subnet_id      = aws_subnet.prod-priv-sub1.id
  route_table_id = aws_route_table.prod-priv-route-table.id
}

resource "aws_route_table_association" "private-association2" {
  subnet_id      = aws_subnet.prod-priv-sub2.id
  route_table_id = aws_route_table.prod-priv-route-table.id
 }

# Creating an internet gateway

resource "aws_internet_gateway" "prod-igw" {
  vpc_id = aws_vpc.rock-project.id

  tags = {
    Name = "prod-igw"
  }
}


# Associating internet gateway with the public route

resource "aws_route" "rock-project" {
  route_table_id         = aws_route_table.prod-pub-route-table.id
  gateway_id             = aws_internet_gateway.prod-igw.id
  destination_cidr_block = "0.0.0.0/0"
}

 # creating of elastic ip

resource "aws_eip" "prod-eip" {
  vpc      = true

  tags = {
    Name = "prod-eip"
  }
}

# Creating nat gateway

resource "aws_nat_gateway" "prod-nat-gateway" {
  subnet_id     = aws_subnet.prod-pub-sub1.id
  allocation_id = aws_eip.prod-eip.id
  connectivity_type = "public"

  tags = {
    Name = "prod-nat-gateway"
  }
  depends_on = [aws_internet_gateway.prod-igw]
}

# Associating nat gateway with private route table

resource "aws_route" "eip-assocation" {
  route_table_id         = aws_route_table.prod-priv-route-table.id
  gateway_id             = aws_nat_gateway.prod-nat-gateway.id
  destination_cidr_block = "0.0.0.0/0"
}

