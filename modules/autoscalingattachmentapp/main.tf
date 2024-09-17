resource "aws_autoscaling_attachment" "asg_attachment_app" {
  autoscaling_group_name = var.autoscaling_group_name_app
  elb                    = var.elb_app
}
