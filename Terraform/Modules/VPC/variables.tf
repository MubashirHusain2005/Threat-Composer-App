variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnet_ids" {
    description = "Public Subnets"
    type        = list(string)
    
}

variable "region" {
    type = string
    default = "eu-west-2"
}

variable "public_ip" {
  type = string
  default = "true"
}

variable "subnet2a" {
  type = string
  default = "eu-west-2a"
}

variable "subnet2b" {
  type = string
  default = "eu-west-2b"
}

variable "vpc_id" {
    type = string
    default = "aws_vpc.Main.id"
} 

variable "gateway_id" {
    type = string 
    default = "aws_internet_gateway.IGW.id"
}
