variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
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


variable "gateway_id" {
    type = string
}

variable "public_subnets" {
  type = map(object({
    cidr = string
    az   = string
  }))
  default = {
    subnet-2a = {
      cidr = "10.0.1.0/24"
      az   = "eu-west-2a"
    }
    subnet-2b = {
      cidr = "10.0.2.0/24"
      az   = "eu-west-2b"
    } 
  }
}
