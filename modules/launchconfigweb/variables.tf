variable "web_instance_type" {
  description = "The instance type"
  type = string
}
variable "web_AMI" {
  description = "The AMI ID"
  type = string
}
variable "security_groups" {
  description = "value of security group"
  type = list(string)
}