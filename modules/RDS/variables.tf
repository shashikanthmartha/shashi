variable "cluster_identifier" {
  description = "The name of the RDS cluster"
  type = string
  default = "my-cluster"
}
variable "engine" {
  description = "The name of the database engine to be used for this DB cluster"
  type = string
  default = "mysql"
}
variable "engine_version" {
  description = "The database engine version"
  type = string
  default = "5.7.19"
}
variable "availability_zones" {
  description = "The availability zones"
  type = list(string)
}
variable "database_name" {
  description = "The name for your database"
  type = string
  default = "mydb"
}
variable "master_username" {
  description = "The master username"
  type = string
  default = "admin"
}
variable "master_password" {
  description = "The master password"
  type = string
  default = "password"
  
}
variable "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  type = string
}
variable "db_security_group_ids" {
  description = "A list of VPC security group IDs to associate with the DB cluster"
  type = list(string)
}