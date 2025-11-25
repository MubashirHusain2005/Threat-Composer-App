# Application Load Balancer Security group 

resource "aws_security_group" "alb_sg" {
  name        = var.alb-sg
  description = "Allow HTTP and HTTPS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = var.from_port[0]
    to_port     = var.to_port[0]
    protocol    = var.protocol
    cidr_blocks = var.cidr_block
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = var.from_port[1]
    to_port     = var.to_port[1]
    protocol    = var.protocol
    cidr_blocks = var.cidr_block
  }


  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr_block
  }
}

#Traffic to ECS Containers must come from ALB on port 8080

resource "aws_security_group" "ecs_sg" {
  name        = "ECS-alb-sg"
  description = "Allow inbound traffic from ALB only"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow traffic from ALB on 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = var.protocol
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = var.from_port[2]
    to_port     = var.to_port[2]
    protocol    = "-1"
    cidr_blocks = var.cidr_block
  }
}
