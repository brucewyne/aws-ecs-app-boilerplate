data "aws_subnet" "main" {
  filter {
    name   = "tag:Name"
    values = ["Main"]
  }
}

data "aws_subnet" "secondary" {
  filter {
    name   = "tag:Name"
    values = ["Secondary"]
  }
}

data "aws_security_group" "lb_sg" {
  filter {
    name   = "group-name"
    values = ["Load Balancer SG - Prod"]
  }
}

data "aws_security_group" "main" {
  filter {
    name   = "group-name"
    values = ["Prod SG"]
  }
}

data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["main"]
  }
}

data "aws_ecs_cluster" "cluster" {
  cluster_name = "production"
}
