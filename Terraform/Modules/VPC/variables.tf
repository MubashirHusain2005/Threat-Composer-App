variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}


variable "region" {
  type    = string
  default = "eu-west-2"
}

variable "public_ip" {
  type    = bool
  default = true
}

variable "private_ip" {
  type    = bool
  default = false
}


variable "name_prefix" {
  type    = string
  default = "ecs"
}

variable "azs" {
  type    = list(string)
  default = ["eu-west-2a", "eu-west-2b"]
}


variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.2.0/24", "10.0.4.0/24"]
}

