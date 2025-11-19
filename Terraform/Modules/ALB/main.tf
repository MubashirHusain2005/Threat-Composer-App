# ALB
resource "aws_lb" "ALB" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg]        
  subnets            = var.public_subnet_ids
  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

# ALB Target Group
resource "aws_lb_target_group" "threatcomposer_tg" {
  name        = "ThreatComposer"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    protocol            = "HTTP"
    port                = "traffic-port"
    path                = "/"
    matcher             = var.matcher
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "ThreatComposer-TG"
  }
}

# ALB Listener for HTTP
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = var.type
    target_group_arn = aws_lb_target_group.threatcomposer_tg.arn
  }
}

# ALB Listener for HTTPS
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type             = var.type
    target_group_arn = aws_lb_target_group.threatcomposer_tg.arn
  }  
  
}

