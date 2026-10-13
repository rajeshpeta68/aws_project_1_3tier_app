locals {
  web_servers = {
    "1" = {
      name      = "private-web-server-1"
      subnet_id = aws_subnet.private-subnet-1a.id
    }
    "2" = {
      name      = "private-web-server-2"
      subnet_id = aws_subnet.private-subnet-1b.id
    }
  }
}

resource "aws_launch_template" "private-ec2-httpd-template" {
  for_each               = local.web_servers
  vpc_security_group_ids = [aws_security_group.ec2-sg-1.id]
  image_id               = data.aws_ami.amazon_linux.id
  name_prefix            = "${each.value.name}-"
  instance_type          = "t3.micro"


  user_data = base64encode(templatefile("${path.module}/scripts/install_httpd.sh", {
    server_name = each.value.name
  }))

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = each.value.name
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
  for_each            = local.web_servers
  name                = each.value.name
  min_size            = 1
  max_size            = 1
  desired_capacity    = 1
  vpc_zone_identifier = [each.value.subnet_id]

  target_group_arns         = [aws_lb_target_group.private-ec2-httpd-tg.arn]
  health_check_type         = "ELB"
  health_check_grace_period = 180
  launch_template {
    id      = aws_launch_template.private-ec2-httpd-template[each.key].id
    version = "$Latest"
  }

}