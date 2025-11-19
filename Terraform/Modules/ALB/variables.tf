variable "public_subnet_ids" {
  description = "Subnets for ALB to deploy in"
  type        = list(string)
}

variable "matcher" {
    type    = string
    default = "200-399"
}

variable "type" {
    type    = string
    default = "forward"
}

variable "http_port" {
    type = number
}

variable "https_port" {
    type = number
}


variable "vpc_id" {
    type = string
}

variable "alb_sg" {
    type = string
}

variable "ecs_sg" {
    type = string
}

variable "acm_certificate_arn" {
    type = string
}