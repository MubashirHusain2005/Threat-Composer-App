variable "container_name" {
  type    = string
  default = "threat-composer-app"
}

variable "public_subnet_ids" {
  description = "Public Subnets"
  type        = list(string)
  default     = ["aws_subnet.Subnet-2a.id", "aws_subnet.Subnet-2b.id"]
}

variable "Container_port" {
  type    = number
  default = 80
}

variable "domain_name" {
  type    = string
  default = "mubashir.site"
}


variable "http_port" {
  type    = string
  default = 80
}

variable "https_port" {
  type    = number
  default = 443
}



variable "region" {
  type    = string
  default = "eu-west-2"
}




