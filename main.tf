module "vpc" {
  source = "./modules/VPC"
  vpc_cidr = var.vpc_cidr
  subnet_cidr_public = var.subnet_cidr_public
  subnet_cidr_web_private = var.subnet_cidr_web_private
  subnet_cidr_database = var.subnet_cidr_database
  subnet_cidr_app_private = var.subnet_cidr_app_private
}
module "web_sg" {
  source = "./modules/SG"
  vpc_id = module.vpc.vpc_id
}
module "db_sg" {
  source = "./modules/DB_SG"
  vpc_id = module.vpc.vpc_id
  web_sg_id = module.web_sg.security_group_id
}
module "rds" {
  source = "./modules/RDS"
  cluster_identifier = var.cluster_identifier
  engine = var.engine
  engine_version = var.engine_version
  availability_zones = module.vpc.database_subnets
  database_name = var.database_name
  master_username = var.master_username
  master_password = var.master_password
  db_security_group_ids = module.db_sg.security_group_id
  db_subnet_group_name = module.vpc.db_subnet_group_name
}


module "aws_launch_configuration_web" {
  source = "./modules/launchconfigweb"
  security_groups = [module.web_sg.this_security_group_id]
  web_instance_type = var.web_instance_type
  web_AMI = var.web_AMI
}
module "aws_launch_configuration_app" {
  source = "./modules/launchconfigapp"
  security_groups = [module.web_sg.this_security_group_id]
  app_instance_type = var.app_instance_type
  app_AMI = var.app_AMI
}
module "ELB_web" {
  source = "./modules/AWSELB_web"
  security_groups = [module.web_sg.this_security_group_id]
}
module "ELB_app" {
  source = "./modules/AWSELB_app"
  security_groups = [module.web_sg.this_security_group_id]
}
module "aws_autoscaling_group_app" {
  source = "./modules/autoscalingapp"
  launch_configuration_app = module.aws_launch_configuration_app.launch_configuration_name_app
  min_size = 1
  max_size = 3
  desired_capacity = 2
  vpc_zone_identifier = module.vpc.public_subnets
  name = var.aws_autoscaling_group_name_app
  health_check_type = "ELB"
  health_check_grace_period = 300
  load_balancers = [module.ELB_app.ELB]
}
module "aws_autoscaling_group" {
  source = "./modules/autoscalingweb"
  launch_configuration_web = module.aws_launch_configuration_web.launch_configuration_name_web
  min_size = 1
  max_size = 3
  desired_capacity = 2
  vpc_zone_identifier = module.vpc.public_subnets
  name = var.aws_autoscaling_group_name_web
  health_check_type = "ELB"
  health_check_grace_period = 300
  load_balancers = [module.ELB_web.ELB]
}
module "aws_autoscaling_attachment_web" {
  source = "./modules/awsautoscalingattachmentweb"
  autoscaling_group_name_web = module.aws_autoscaling_group.aws_autoscaling_group_name_web
  elb_web = module.ELB_web.elb_web
  elb_app = module.ELB_app.elb_app
}
module "aws_autoscaling_attachment_app" {
  source = "./modules/awsautoscalingattachmentapp"
  autoscaling_group_name_app = module.aws_autoscaling_group.aws_autoscaling_group_name_app
  elb_app = module.ELB_app.elb_app
}