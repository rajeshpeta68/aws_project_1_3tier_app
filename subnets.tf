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