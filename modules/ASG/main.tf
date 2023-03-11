# ASG  
resource "aws_autoscaling_group" "K8-asg" {
  name                      = var.asg_id
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.K8_launch_config.id
  vpc_zone_identifier       = [var.asg_subnet, var.asg_subnet2] 
  target_group_arns         = [var.lb_tg_arn] 

  tag {
    key                 = "Name"
    value               = "Worker_Node_asg"
    propagate_at_launch = true
  }
}  

# ASG Policy 
resource "aws_autoscaling_policy" "K8-asg-policy" {
  name                   = var.asg_policy
  adjustment_type        = "ChangeInCapacity" 
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.K8-asg.id 
    target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = var.asg_policy_targetvalue
  }
}

# Launch Configuration 
resource "aws_launch_configuration" "K8_launch_config" {
  image_id      = aws_ami_from_instance.launch_config_ami.id
  instance_type = var.lc_instancetype 
  associate_public_ip_address = true
  security_groups = [var.sg_name] 
  key_name = var.keypair
} 

#AMI  
resource "aws_ami_from_instance" "launch_config_ami" {
  name               = var.launch_config_ami
  source_instance_id = var.ami_source_instance
}