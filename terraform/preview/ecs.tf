data "aws_subnet" "main" {
  filter {
    name   = "tag:Name"
    values = ["Main - dev"]
  }
}

data "aws_subnet" "secondary" {
  filter {
    name   = "tag:Name"
    values = ["Secondary - dev"]
  }
}

data "aws_security_group" "lb_sg" {
  filter {
    name   = "group-name"
    values = ["Load Balancer SG - dev"]
  }
}

data "aws_security_group" "main" {
  filter {
    name   = "group-name"
    values = ["Dev SG"]
  }
}

data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["main - dev"]
  }
}

data "aws_ecs_cluster" "cluster" {
  cluster_name = "dev"
}
