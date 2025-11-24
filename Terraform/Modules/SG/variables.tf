variable "cidr_block" {
  description = "CIDR blocks for HTTPS access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "protocol" {
    description = "TCP used for sending traffic"
    type        = string
    default     = "tcp"
}

variable "from_port" {
    type    = list(string)
    default = ["80", "443", "0"]
}

variable "to_port" {
    type    =  list(string)
    default = ["80", "443", "0"]
}


variable "vpc_id" {
    type = string
}

variable "alb-sg" {
    type    = string
    default = "alb-sg"
}