variable "vpc_cidr" {
  description = "VPC CIDR Range"
  type = string
}

variable "subnet_cidr_public" {
    description = "Subnet public CIDRS"
    type = list(string)
}
variable "subnet_cidr_web_private" {
    description = "Subnet private CIDRS"
    type = list(string)
}
variable "subnet_cidr_app_private" {
    description = "Subnet private CIDRS"
    type = list(string)
}
variable "subnet_cidr_database" {
    description = "Subnet database CIDRS"
    type = list(string)
}
variable "subnet_names_public" {
    description = "Subnet names"
    type = list(string)
    default = [ "PublicSubnet1", "PublicSubnet2" ]
}
variable "subnet_names_web_private" {
    description = "Subnet names"
    type = list(string)
    default = [ "privateSubnet1", "privateSubnet2" ]
}
variable "subnet_names_app_private" {
    description = "Subnet names"
    type = list(string)
    default = [ "privateSubnet3", "privateSubnet4" ]
}
variable "subnet_names_database" {
    description = "Subnet names"
    type = list(string)
    default = [ "DBSubnet1", "DBSubnet2" ]
}