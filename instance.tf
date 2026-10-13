resource "aws_instance" "bastion-instance" {
  for_each = {
    "1a" = aws_subnet.public-subnet-1a.id
    "1b" = aws_subnet.public-subnet-1b.id
  }
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t3.micro"
  security_groups             = [aws_security_group.public-ec2-sg-1.id]
  associate_public_ip_address = true
  key_name                    = "base"
  subnet_id                   = each.value

  tags = {
    Name = "bastion-instance-${each.key}"
  }

}