# --- root / main.tf ---

provider "aws" {
  region = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
<<<<<<< HEAD

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "example-cluster"
}

resource "aws_ecs_task_definition" "ecs_cluster_task" {
  family = "example-task-definition"

  container_definitions = <<EOF
[
  {
    "name": "centos-container",
    "image": "centos:7",
    "cpu": 1024,
    "memory": 2048,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
=======

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "ecs-cluster"
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family = "ecs-task-definition"

  container_definitions = <<DEFINITION
[
  {
    "name": "example-container",
    "image": "registry.centos.org/centos-stream/9/os/x86_64/images/centos-stream-9-20221116.0.x86_64.qcow2",
    "memory": 1028,
    "cpu": 512,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
DEFINITION
}

resource "aws_ecs_service" "ecs_service" {
  name            = "ecs-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = 1

  launch_type = "EC2"

  network_configuration {
    assign_public_ip = false
    security_groups = [
      aws_security_group.ecs_sg.id
    ]
    subnets = aws_subnet.private_subnet.*.id
  }
}


resource "aws_vpc" "vpc_ecs" {
  cidr_block = "10.0.0.0/16"
}


resource "aws_subnet" "private_subnet" {
  # count = 2
  # cidr_block = "10.0.${count.index + 1}.0/24"
  cidr_block = "10.0.2.0/24"
  vpc_id     = aws_vpc.vpc_ecs.id
}

resource "aws_security_group" "ecs_sg" {
  name        = "ecs-security-group"
  description = "Allow HTTP traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
>>>>>>> main
  }
}

resource "aws_subnet" "example" {
  count = 2

  cidr_block = "10.0.${count.index + 1}.0/24"
  vpc_id     = aws_vpc.example.id
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

# resource "aws_ecs_cluster" "cluster" {
#   name = "project-ecs-cluster"

#   capacity_providers = ["FARGATE_SPOT", "FARGATE"]

#   default_capacity_provider_strategy {
#     capacity_provider = "FARGATE_SPOT"
#   }

#   setting {
#     name  = "containerInsights"
#     value = "disabled"
#   }
# }

>>>>>>> main
# module "ecs-fargate" {
#   source  = "umotif-public/ecs-fargate/aws"
#   version = "~> 6.1.0"

#   name_prefix        = "ecs-fargate-centos"
#   vpc_id             = "vpc-0457b2d0b1eefd0a3"
#   private_subnet_ids = ["subnet-04eaf32cc00b76312"]

#   cluster_id = aws_ecs_cluster.cluster.id

#   task_container_image   = "centos"
#   task_definition_cpu    = 256
#   task_definition_memory = 512

#   task_container_port             = 80
#   task_container_assign_public_ip = true

#   load_balanced = false

#   target_groups = [
#     {
#       target_group_name = "tg-fargate-centos"
#       container_port    = 80
#     }
#   ]

#   health_check = {
#     port = "traffic-port"
#     path = "/"
#   }

#   tags = {
#     Environment = "test"
#     Project     = "Test"
#   }
<<<<<<< HEAD
# }

=======
# }
>>>>>>> main
