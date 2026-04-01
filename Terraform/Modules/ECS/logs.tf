resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/my-ecs-task"
  retention_in_days = var.retention_in_days

  tags = {
    Name = "ecs-task-logs"
  }
}