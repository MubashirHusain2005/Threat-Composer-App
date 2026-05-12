variable "container_name" {
  type    = string
  default = "threat-composer-app"
}


variable "Container_port" {
  type    = number
  default = 8080
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



variable "name_prefix" {
  type    = string
  default = "ecs"
}

