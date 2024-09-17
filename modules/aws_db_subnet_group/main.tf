 resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "main"
  subnet_ids = var.db_subenet_ids
}
