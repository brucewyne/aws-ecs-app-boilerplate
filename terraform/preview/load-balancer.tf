
data "aws_lb" "dev" {
  name = "lb-dev"
}

resource "aws_lb_target_group" "app-tg" {
  name     = "${var.service_name}-target-group"
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

data "aws_lb_listener" "dev" {
  load_balancer_arn = data.aws_lb.dev.arn
  port = 80
}

resource "aws_lb_listener_rule" "listener_rule" {
  listener_arn = data.aws_lb_listener.dev.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-tg.arn
  }

  condition {
    host_header {
      values = ["${var.service_name}.mydomain.com"]
    }
  }
}
