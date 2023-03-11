# App LB 
resource "aws_lb" "K8-lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_sg]
  subnets            = [var.lb_subnet1, var.lb_subnet2]

  enable_deletion_protection = false
} 

# lb TG  
resource "aws_lb_target_group" "K8-lb-tg" {
  name        = var.lb-tg
  target_type = var.lb_tg_targettype
  port        = var.lb-tg_port
  protocol    = var.protocol
  vpc_id      = var.vpc 
  health_check {
    healthy_threshold = 3 
    unhealthy_threshold = 3 
    timeout = 4 
    interval = 45
  }
} 

#LB listener for port 80
resource "aws_lb_listener" "K8-lb-listener" {
  load_balancer_arn = aws_lb.K8-lb.arn
  port              = var.lb_listener_port
  protocol          = var.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.K8-lb-tg.arn
  }
} 

# LB Target_group Attachment 
resource "aws_lb_target_group_attachment" "test" {
  count = 2
  target_group_arn = aws_lb_target_group.K8-lb-tg.arn
  target_id        =  "${element(split(",", join(",", var.lb_instance)), count.index)}"
  port             = 30220
}