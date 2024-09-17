resource "aws_rds_cluster" "default" {
  cluster_identifier      = var.cluster_identifier
  engine                  = var.engine
  engine_version          = var.engine_version
  availability_zones      = var.availability_zones
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = var.master_password
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}
resource "aws_db_instance" "default" {
  instance_class          = "db.t2.micro"
  engine                  = aws_rds_cluster.default.engine
  engine_version          = aws_rds_cluster.default.engine_version
  db_subnet_group_name    = var.db_subnet_group_name
  vpc_security_group_ids  = var.db_security_group_ids
}
