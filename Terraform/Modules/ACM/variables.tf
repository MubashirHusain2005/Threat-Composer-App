variable "time_to_live" {
    description = "Time to Live for the route 53"
    type        = number
    default     = 60
}

variable "domain_name" {
    type = string
    default = "mubashir.site"
}


