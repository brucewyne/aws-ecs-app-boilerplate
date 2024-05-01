resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/ecs/myapp"
  retention_in_days = 3
}

data "aws_iam_role" "ecs_role" {
  name = "ecs_role"
}

resource "aws_ecs_task_definition" "task" {
  family                   = "myapp"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = data.aws_iam_role.ecs_role.arn

  container_definitions = jsonencode([
    {
      image = var.docker_image
      name  = "myapp"
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = aws_cloudwatch_log_group.log_group.name,
          awslogs-region        = "us-east-1",
          awslogs-stream-prefix  = "ecs"
        }
      }
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    },
  ])
}
