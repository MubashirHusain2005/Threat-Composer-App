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

variable "ALB_type" {
    type = string
    default = "application"
}

variable "ssl_policy" {
    type    = string
    default = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
}

variable "interval" {
    type    = number
    default = 30
}

variable "timeout" {
    type    = number
    default = 5

}

variable "public_subnet_ids" {
    description = "Public Subnets"
    type        = list(string)
    
}

