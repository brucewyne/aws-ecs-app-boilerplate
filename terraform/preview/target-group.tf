resource "aws_lb_target_group" "target_group" {
  name     = "${var.service_name}-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0c89fa810244b75b7"
  target_type = "ip"

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    timeout             = 3
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}
