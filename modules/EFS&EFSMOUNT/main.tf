resource "aws_efs_file_system" "efs" {}

resource "aws_efs_mount_target" "efs_mount" {
  count          = 1
  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = element(var.subnet_cidr_privates, 0)
  security_groups = var.security_groups
}