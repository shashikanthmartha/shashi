variable "aws_autoscaling_group_name_app" {
  description = "The name of the autoscaling group"
  type = string
}
variable "vpc_zone_identifier" {
  description = "The VPC zone identifier"
    type = list(string)
}
variable "launch_configuration_app" {
  description = "The name of the launch configuration"
  type = string
}