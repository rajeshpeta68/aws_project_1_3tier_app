resource "aws_route_table" "public-route-1a" {
  vpc_id = aws_vpc.web-app-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public-igw-1a.id
  }

}

resource "aws_route_table" "public-route-1b" {
  vpc_id = aws_vpc.web-app-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public-igw-1a.id
  }

}

resource "aws_route_table_association" "public-route-1a-ascn" {
  subnet_id      = aws_subnet.public-subnet-1a.id
  route_table_id = aws_route_table.public-route-1a.id

}

resource "aws_route_table_association" "public-route-1b-ascn" {
  subnet_id      = aws_subnet.public-subnet-1b.id
  route_table_id = aws_route_table.public-route-1b.id

}


resource "aws_route_table" "private-route-1a" {
  vpc_id = aws_vpc.web-app-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw-1a.id
  }

}

resource "aws_route_table" "private-route-1b" {
  vpc_id = aws_vpc.web-app-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw-1b.id
  }

}

resource "aws_route_table_association" "private_route-1a-ascn" {
  subnet_id      = aws_subnet.private-subnet-1a.id
  route_table_id = aws_subnet.private-subnet-1a.id

}

resource "aws_route_table_association" "private_route-1b-ascn" {
  subnet_id      = aws_subnet.private-subnet-1b.id
  route_table_id = aws_subnet.private-subnet-1b.id

}