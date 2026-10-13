resource "aws_launch_template" "private-ec2-httpd-template" {
  vpc_security_group_ids = [aws_security_group.ec2-sg-1.id]
  image_id               = data.aws_ami.amazon_linux.id
  name_prefix            = "web-server-"
  instance_type          = "t3.micro"


  user_data = base64encode(templatefile("${path.module}/scripts/install_httpd.sh", {
    server_name = "web-server-1"
  }))

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = "web-server-1"
      Environment = "dev"
    }
  }

}

resource "aws_lb_target_group" "private-ec2-httpd-tg" {
  name     = "web-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.web-app-vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 10
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "private-ec2-httpd-tg"
  }

}

resource "aws_lb" "alb-for-ec2-private" {
  name               = "alb-for-ec2-private"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.alb-sg-1.id]
  subnets            = [aws_subnet.public-subnet-1a.id, aws_subnet.public-subnet-1b.id]

  tags = {
    Name = "alb-for-ec2-private"
  }

}

# resource "aws_lb_target_group_attachment" "alb-tg-atcmnt" {
#   target_group_arn = aws_lb_target_group.private-ec2-httpd-tg.arn
#   target_id        = aws_autoscaling_group.web-asg.id
#   port             = 80
# }

resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.alb-for-ec2-private.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private-ec2-httpd-tg.arn
  }

}

resource "aws_autoscaling_group" "web-asg" {
  name                = "web-asg"
  min_size            = 2
  max_size            = 4
  desired_capacity    = 2
  vpc_zone_identifier = [aws_subnet.private-subnet-1a.id, aws_subnet.private-subnet-1b.id]

  target_group_arns         = [aws_lb_target_group.private-ec2-httpd-tg.arn]
  health_check_type         = "ELB"
  health_check_grace_period = 180
  launch_template {
    id      = aws_launch_template.private-ec2-httpd-template.id
    version = "$Latest"
  }

}