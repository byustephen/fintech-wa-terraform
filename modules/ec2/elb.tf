resource "aws_lb_target_group" "primary-public-target-group" {
  name     = "primary-public-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  slow_start  = "90"

  health_check {
    path = "/status.html"
    port = "traffic-port"
    matcher = "200"
    unhealthy_threshold = 3
    healthy_threshold = 2
    interval = 20
  }
}

resource "aws_lb_target_group_attachment" "target-attachment-public-a" {
  target_group_arn = aws_lb_target_group.primary-public-target-group.arn
  target_id        = aws_instance.primary-public-instance-a.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "target-attachment-public-b" {
  target_group_arn = aws_lb_target_group.primary-public-target-group.arn
  target_id        = aws_instance.primary-public-instance-b.id
  port             = 80
}

resource "aws_lb" "primary-public-alb" {
  name               = "primary-public-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.primary_public_security_group.id]
  subnets            = [var.subnet_ids[0],var.subnet_ids[1]]

  enable_deletion_protection = false

  tags = {
    Name = "Primary Public Alb"
  }
}

resource "aws_lb_listener" "primary-public-listener" {
  load_balancer_arn = aws_lb.primary-public-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.primary-public-target-group.arn
  }
}