locals {

  aws_config_bucket_name       = "${var.aws_environment}-${var.aws_region}-s3-aws-config-bucket"
  aws_config_bucket_key_prefix = var.aws_environment

  security_group_web_inbound_rules = [{
    "from" : "80"
    "to" : "80"
    "protocol" : "tcp"
    "description" : "HTTP port"
    "security_group" : aws_security_group.web_server_alb_securitygroup.id
  },
  {
    "from" : "443"
    "to" : "443"
    "protocol" : "tcp"
    "description" : "HTTPS port"
    "security_group" : aws_security_group.web_server_alb_securitygroup.id
  }]

  security_group_web_alb_inbound_rules = [{
    "from" : "80"
    "to" : "80"
    "protocol" : "tcp"
    "description" : "HTTP port"
    "access_cidr" : "0.0.0.0/0"
  },
  {
    "from" : "443"
    "to" : "443"
    "protocol" : "tcp"
    "description" : "HTTPS port"
    "access_cidr" : "0.0.0.0/0"
  }]

  security_group_app_inbound_rules = [{
    "from" : "0"
    "to" : "0"
    "protocol" : "-1"
    "description" : "All traffic"
    "security_group" : aws_security_group.web_server_securitygroup.id
  }]

  security_group_outbound_rules = [{
    "from" : "0"
    "to" : "0"
    "protocol" : "-1"
    "description" : "All traffic"
    "access_cidr" : "0.0.0.0/0"
  }]

  tags = {
    tags_shared_by_all_components = {
      project            = "challenge"
      environment        = var.aws_environment
    }

    component_specific_tags = {
      public_subnet_tags = {
        network_tier = "public"
        role         = "subnet"
      }

      private_subnet_tags = {
        network_tier = "private"
        role         = "subnet"
      }

      vpc_tags = {
        Name = "${var.aws_environment}-${var.aws_region}-vpc" # override the name of the VPC given by the module and add a role tag
        role = "vpc"
      }

      route_table_tags = {
        role = "route_table"
      }

      nat_gateway_tags = {
        role = "nat_gateway"
      }

      internet_gateway_tags = {
        role = "internet_gateway"
      }

      root_volume_tags = {
        role = "root_volume"
      }

      web_server_tags = {
        role = "web_server"
      }

      app_server_tags = {
        role = "app_server"
      }

      security_group_tags = {
        role = "security_group"
      }

      alb_tags = {
        role = "application_lb"
      }

      nlb_tags = {
        role = "network_lb"
      }
    }
  }
}
