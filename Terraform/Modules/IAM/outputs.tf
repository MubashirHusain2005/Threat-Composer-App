output "ecs_task_execution_role" {
    value = aws_iam_role.ecs_task_execution_role.arn
}

output "github_actions_role" {
    value = aws_iam_role.github_actions.id
}
