vpc_name                                        = "dev-vpc"
vpc_cidr_address                                = "10.1.0.0/16"
vpc_subnet_azs                                  = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
vpc_private_subnet_cidrs                        = ["10.1.1.0/24", "10.1.3.0/24", "10.1.5.0/24"]
vpc_public_subnet_cidrs                         = ["10.1.2.0/24", "10.1.4.0/24", "10.1.6.0/24"]
enable_nat_gateway                              = true
aws_environment                                 = "dev"
aws_region                                      = "eu-west-2"
ami_id                                          = "ami-06178cf087598769c"
instance_type                                   = "t2.micro"
root_volume_type                                = "gp2"
root_volume_size                                = 50
app_server_count                                = 2
web_server_count                                = 4
db_instance_type                                = "db.t2.large"
db_volume_size                                  = 5
db_engine                                       = "mysql"
db_version                                      = "5.7.19"
db_major_engine_version                         = "5.7"
db_family                                       = "mysql5.7"
