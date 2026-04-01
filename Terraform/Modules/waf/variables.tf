variable "web_acl_description" {
  description = "The description of the WAF web ACL"
  default     = "My Web ACL"
}
variable "rule_name" {
  description = "The name of the WAF rule"
  default     = "bad-bot-rule"
}
variable "rule_priority" {
  description = "The priority of the WAF rule"
  default     = 1
}

variable "alb" {
  type = string
}