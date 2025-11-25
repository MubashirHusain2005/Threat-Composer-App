# VPC Module
module "VPC" {
  source            = "./Modules/VPC"
  public_subnet_ids = var.public_subnet_ids
  
}

# SG Module
module "SG" {
  source = "./Modules/SG"
  vpc_id = module.VPC.vpc_id

}

# IAM Module

module "IAM" {
  source = "./Modules/IAM"
} 

# ALB Module

module "ALB" {
  source              = "./Modules/ALB"
  http_port           = var.http_port
  https_port          = var.https_port
  public_subnet_ids   = module.VPC.public_subnet_ids
  vpc_id              = module.VPC.vpc_id
  ecs_sg              = module.SG.ecs_sg
  alb_sg              = module.SG.alb_sg
  acm_certificate_arn = module.ACM.acm_certificate_arn

}


# ACM Module

module "ACM" {
  source      = "./Modules/ACM"
  domain_name = var.domain_name

}

# Route 53 Module
module "Route53" {
  source                    = "./Modules/Route53"
  alb_dns_name              = module.ALB.alb_dns_name
  domain_name               = var.domain_name
  alb_zone_id               = module.ALB.alb_zone_id
  domain_validation_options = module.ACM.domain_validation_options
  certificate_arn           = module.ACM.acm_certificate_arn

}

# ECS MODULE

module "ECS" {
  source             = "./Modules/ECS"
  alb_target_grp_arn = module.ALB.alb_target_grp_arn
  container_name     = var.container_name
  public_subnet_ids  = module.VPC.public_subnet_ids
  execution_role_arn = module.IAM.ecs_task_execution_role
  ecs_sg             = module.SG.ecs_sg
}

