resource "aws_autoscaling_group" "app_asg" {
  desired_capacity     = 2
  max_size             = 2
  min_size             = 2
  vpc_zone_identifier  = var.vpc_zone_identifier
  launch_configuration = var.launch_configuration_app

  tag {
    key                 = var.aws_autoscaling_group_name_app
    value               = "web-instance"
    propagate_at_launch = true
  }
}