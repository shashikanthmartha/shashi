resource "aws_launch_configuration" "app_lc" {
  name          = "app-lc"
  image_id      = var.app_AMI # Replace with a valid AMI ID
  instance_type = var.app_instance_type
  security_groups = var.security_groups

  lifecycle {
    create_before_destroy = true
  }
}