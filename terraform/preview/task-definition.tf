data "aws_iam_role" "ecs_role" {
  name = "ecs_role_dev"
}

resource "aws_ecs_task_definition" "app-qa" {
  family                   = "${var.service_name}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = data.aws_iam_role.ecs_role.arn
  skip_destroy             = true
  container_definitions = jsonencode([
    {
      image = var.docker_image
      name  = var.service_name
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-create-group  = "true",
          awslogs-group         = "/ecs/${var.service_name}",
          awslogs-region        = "us-east-1",
          awslogs-stream-prefix = "ecs"
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
