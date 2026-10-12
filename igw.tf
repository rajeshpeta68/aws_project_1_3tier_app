resource "aws_internet_gateway" "public-igw-1a" {
  vpc_id = aws_vpc.web-app-vpc.id

  tags = {
    Name = "public-igw-1a"
  }

}

# resource "aws_internet_gateway" "public-igw-1b" {
#     vpc_id = aws_vpc.web-app-vpc.id

#     tags = {
#         Name = "public-igw-1b"
#     }

# }

