resource "aws_launch_configuration" "web_lc" {
  name          = "web-lc"
  image_id      = var.web_AMI # Replace with a valid AMI ID
  instance_type = var.web_instance_type
  security_groups = var.security_groups

  lifecycle {
    create_before_destroy = true
  }
}