# --- root / main.tf ---

provider "aws" {
  region = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

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
# }

