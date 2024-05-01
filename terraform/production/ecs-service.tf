resource "aws_ecs_service" "app-preview" {
  name            = "app-service"
  cluster         = data.aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = aws_lb_target_group.app-tg.arn
    container_name   = "myapp"
    container_port   = 3000
  }

  network_configuration {
    subnets          = [data.aws_subnet.main.id, data.aws_subnet.secondary.id]
    security_groups  = [data.aws_security_group.main.id]
    assign_public_ip = true
  }

  depends_on = [data.aws_lb_listener.dev]
}
