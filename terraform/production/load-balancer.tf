data "aws_lb" "production" {
  name = "production-lb"
}

resource "aws_lb_target_group" "app-tg" {
  name     = "myapp-lb-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.main.id
  target_type = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 30
    matcher             = "200-399"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
  }
}

data "aws_lb_listener" "production" {
  load_balancer_arn = data.aws_lb.production.arn
  port = 80
}

resource "aws_lb_listener_rule" "listener_rule" {
  listener_arn = data.aws_lb_listener.production.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-tg.arn
  }

  condition {
    host_header {
      values = ["app.mydomain.com"]
    }
  }
}
