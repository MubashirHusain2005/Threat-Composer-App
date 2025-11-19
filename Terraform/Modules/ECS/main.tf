# ECS Cluster

resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
}

#Collects Logs from ECS containers
resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/my-ecs-task"
  retention_in_days = 7

  tags = {
    Name = "ecs-task-logs"
  }
}



# ECS Task Definition

resource "aws_ecs_task_definition" "task" {
  depends_on               = [ aws_cloudwatch_log_group.ecs_logs ]
  family                   = var.family
  network_mode             = "awsvpc"                
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.memory
  execution_role_arn       = var.execution_role_arn #Helps to pull the image from ECR
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name      = "threat-composer-app"
      image     = "038774803581.dkr.ecr.eu-west-2.amazonaws.com/threat-composer-app:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ],
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/my-ecs-task"
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

# ECS Service

resource "aws_ecs_service" "app_service" {
  name            = "my-fargate-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 2
  launch_type     = "FARGATE"
  platform_version = "LATEST"

  # Network settings for Fargate
  network_configuration {
    subnets          = var.public_subnet_ids
    security_groups  = [var.ecs_sg]
    assign_public_ip = true                            
  }

  # Connect to Application Load Balancer
  load_balancer {
    target_group_arn = var.alb_target_grp_arn
    container_name   = "threat-composer-app"
    container_port   = 80
  }

  depends_on = [
    aws_ecs_cluster.main,
    aws_ecs_task_definition.task

  ] 
}

