data "aws_route53_zone" "primary" {
  name = var.domain_name

}

# A record so I can map www.mubashir.site onto the ALB DNS
resource "aws_route53_record" "MS" {
  zone_id = data.aws_route53_zone.primary.id
  name    = "www.${var.domain_name}"
  type    = var.record_type


  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = var.health
  }
}


resource "aws_route53_record" "apex" {
  zone_id = data.aws_route53_zone.primary.id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = var.health
  }
}