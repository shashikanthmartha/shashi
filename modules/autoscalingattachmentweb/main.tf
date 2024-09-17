resource "aws_autoscaling_attachment" "asg_attachment_web_1" {
  autoscaling_group_name = var.autoscaling_group_name_web
  elb                    = var.elb_web
}
resource "aws_autoscaling_attachment" "asg_attachment_web_2" {
  autoscaling_group_name = var.autoscaling_group_name_web
  elb                    = var.elb_app
}
