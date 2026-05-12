# VPC Module
module "vpc" {
  source = "./modules/vpc"

}

# Security-group Module
module "security-group" {
  source = "./modules/security-group"
  vpc_id = module.vpc.vpc_id

}

# IAM Module

module "iam" {
  source      = "./modules/iam"
  name_prefix = var.name_prefix

}

# ALB Module

module "alb" {
  source              = "./modules/alb"
  http_port           = var.http_port
  https_port          = var.https_port
  public_subnet_ids   = module.vpc.public_subnet_ids
  vpc_id              = module.vpc.vpc_id
  ecs_sg              = module.security-group.ecs_sg
  alb_sg              = module.security-group.alb_sg
  acm_certificate_arn = module.acm.acm_certificate_arn
  name_prefix         = var.name_prefix

  depends_on = [module.vpc, module.acm]

}

# ACM Module

module "acm" {
  source      = "./modules/acm"
  domain_name = var.domain_name
  name_prefix = var.name_prefix

  depends_on = [module.vpc]
}

# Route 53 Module
module "route53" {
  source                    = "./modules/route53"
  alb_dns_name              = module.alb.alb_dns_name
  domain_name               = var.domain_name
  alb_zone_id               = module.alb.alb_zone_id
  domain_validation_options = module.acm.domain_validation_options
  certificate_arn           = module.acm.acm_certificate_arn

  depends_on = [module.alb]

}

# ECS MODULE

module "ecs" {
  source             = "./modules/ecs"
  alb_target_grp_arn = module.alb.alb_target_grp_arn
  public_subnet_ids  = module.vpc.public_subnet_ids
  execution_role_arn = module.iam.ecs_task_execution_role
  ecs_sg             = module.security-group.ecs_sg
  private_subnet_ids = module.vpc.private_subnet_ids
  name_prefix        = var.name_prefix
  task_role_arn      = module.iam.ecs_task_role

  depends_on = [module.vpc, module.alb]
}

module "waf" {
  source = "./modules/waf"
  alb    = module.alb.alb
}

