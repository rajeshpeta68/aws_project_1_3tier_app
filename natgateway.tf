resource "aws_eip" "nat-eip-1a" {
  domain = "vpc"
  tags = {
    Name = "nat-eip-1a"
  }
}

resource "aws_eip" "nat-eip-1b" {
  domain = "vpc"
  tags = {
    Name = "nat-eip-1b"
  }

}


resource "aws_nat_gateway" "nat-gw-1a" {
  allocation_id = aws_eip.nat-eip-1a.id
  #vpc_id        = aws_vpc.web-app-vpc.id
  subnet_id = aws_subnet.public-subnet-1a.id

  tags = {
    Name = "nat-gw-1a"
  }
  depends_on = [aws_internet_gateway.public-igw-1a]

}

resource "aws_nat_gateway" "nat-gw-1b" {
  #vpc_id        = aws_vpc.web-app-vpc.id
  allocation_id = aws_eip.nat-eip-1b.id
  subnet_id     = aws_subnet.public-subnet-1b.id

  tags = {
    Name = "nat-gw-1b"
  }
  depends_on = [aws_internet_gateway.public-igw-1a]

}

