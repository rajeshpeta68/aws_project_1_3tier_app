resource "aws_subnet" "public-subnet-1a" {
  vpc_id            = aws_vpc.web-app-vpc.id
  availability_zone = "ap-south-2a"
  cidr_block        = "10.0.1.0/24"

  tags = {
    Name = "public-subnet-1a"
  }
}

resource "aws_subnet" "private-subnet-1a" {
  vpc_id            = aws_vpc.web-app-vpc.id
  availability_zone = "ap-south-2a"
  cidr_block        = "10.0.2.0/24"

  tags = {
    Name = "private-subnet-1a"
  }

}

resource "aws_subnet" "private-subnet-2a" {
  vpc_id            = aws_vpc.web-app-vpc.id
  availability_zone = "ap-south-2a"
  cidr_block        = "10.0.3.0/24"

  tags = {
    Name = "private-subnet-2a"
  }

}


resource "aws_subnet" "public-subnet-1b" {
  vpc_id            = aws_vpc.web-app-vpc.id
  availability_zone = "ap-south-2b"
  cidr_block        = "10.0.4.0/24"

  tags = {
    Name = "public-subnet-1b"
  }
}

resource "aws_subnet" "private-subnet-1b" {
  vpc_id            = aws_vpc.web-app-vpc.id
  availability_zone = "ap-south-2b"
  cidr_block        = "10.0.5.0/24"

  tags = {
    Name = "private-subnet-1b"
  }

}

resource "aws_subnet" "private-subnet-2b" {
  vpc_id            = aws_vpc.web-app-vpc.id
  availability_zone = "ap-south-2b"
  cidr_block        = "10.0.6.0/24"

  tags = {
    Name = "private-subnet-2b"
  }

}

resource "aws_db_subnet_group" "web-app-db-subnet-grp" {
  name        = "web-app-db-subnet-grp"
  description = "private subnets for web application database"

  subnet_ids = [aws_subnet.private-subnet-2a.id, aws_subnet.private-subnet-2b.id]

  tags = {
    Name = "web-app.db-subnet-grp"
  }
}

