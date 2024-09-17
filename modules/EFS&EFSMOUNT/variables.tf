variable "security_groups" {
    description = "The security groups for the ELB"
    type = list(string)
}
variable "subnet_cidr_privates" {
    description = "The CIDR block for the private subnet"
    type = list(string)
}