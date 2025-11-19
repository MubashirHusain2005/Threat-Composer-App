variable "cluster_name" {
    description = "Cluster ID"
    type        = string
    default     = "my-ecs-cluster"
}

variable "container_name" {
    type = string
}

variable "fargate_cpu" {
    type = string
    default = 256
}

variable "Container_port" {
    type    = number
    default = 80
}

variable "family" {
    type    = string
    default = "my-ecs-task"
}

variable "memory" {
    type    = string
    default = "512"
}

variable "region" {
    type    = string
    default = "eu-west-2"
}

variable "alb_target_grp_arn" {
  type = string
}


variable "execution_role_arn" {
    type = string
}

variable "ecs_sg" {
    type = string
}

variable "public_subnet_ids" {
    type = list(string)
}