
resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    tags = {
      "Name" = "my_vpc"
    }
}


resource "aws_subnet" "public" {
 count = length(var.subnet_cidr_public)
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_cidr_public[count.index]
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = var.subnet_names_public[count.index]
  }
}

resource "aws_subnet" "web_private" {
  count = length(var.subnet_cidr_web_private)
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_cidr_web_private[count.index]
  availability_zone = element(data.aws_availability_zones.available.names, count.index )
  tags = {
    Name = var.subnet_names_web_private[count.index]
  }
}
resource "aws_subnet" "app_private" {
  count = length(var.subnet_cidr_app_private)
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_cidr_app_private[count.index]
  availability_zone = element(data.aws_availability_zones.available.names, count.index )
  tags = {
    Name = var.subnet_names_app_private[count.index]
  }
}
resource "aws_subnet" "database" {
  count = length(var.subnet_cidr_database)
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_cidr_database[count.index]
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = var.subnet_names_database[count.index]
  }
}

