variable "name_prefix" {
  type = string
}


variable "fargate_cpu" {
  type    = number
  default = 256
}

variable "container_port" {
  type    = number
  default = 8080
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

variable "network_mode" {
  type    = string
  default = "awsvpc"
}

variable "launch_type" {
  type    = string
  default = "FARGATE"

}

variable "desired_count" {
  type    = number
  default = 2
}

variable "retention_in_days" {
  type    = number
  default = 7
}

variable "image" {
  type    = string
  default = "038774803581.dkr.ecr.eu-west-2.amazonaws.com/ecs:v1"
}

variable "protocol" {
  type    = string
  default = "tcp"
}

variable "app_name" {
  type    = string
  default = "threat-composer-app"
}


variable "private_subnet_ids" {
  type = list(any)
}

variable "task_role_arn" {
  type = string
}