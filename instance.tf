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

  user_data = <<-EOF
    #!/bin/bash
    install -d -m 700 -o ec2-user -g ec2-user /home/ec2-user/.ssh
    cat > /home/ec2-user/.ssh/base.pem <<'KEY'
    ${file("${path.module}/base.pem")}
    KEY
    chown ec2-user:ec2-user /home/ec2-user/.ssh/base.pem
    chmod 400 /home/ec2-user/.ssh/base.pem
  EOF

  tags = {
    Name = "bastion-instance-${each.key}"
  }

}