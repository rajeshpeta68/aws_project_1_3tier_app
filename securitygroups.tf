resource "aws_security_group" "alb-sg-1" {
  name   = "alb-sg-1"
  vpc_id = aws_vpc.web-app-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ingress {
  #     from_port = "22"
  #     to_port = "22"
  #     protocol = "tcp"
  #     cidr_blocks = [ "0.0.0.0/0" ]
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "alb-sg-1"
  }
}

resource "aws_security_group" "ec2-sg-1" {
  name   = "ec2-sg-1"
  vpc_id = aws_vpc.web-app-vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg-1.id]
  }

  # ingress {
  #     from_port = "22"
  #     to_port = "22"
  #     protocol = "tcp"
  #     cidr_blocks = [ aws_security_group.alb-sg-1.id ]
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg-1"
  }
}

#DB security groups #

resource "aws_security_group" "db-sg-1" {
  name   = "db-sg-1"
  vpc_id = aws_vpc.web-app-vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2-sg-1.id]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2-sg-1.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-sg-1"
  }

}

resource "aws_security_group" "public-ec2-sg-1" {
  name   = "public-ec2-sg-1"
  vpc_id = aws_vpc.web-app-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "public-ec2-sg-1"
  }


}