locals {

  aws_config_bucket_name       = "${var.aws_environment}-${var.aws_region}-s3-aws-config-bucket"
  aws_config_bucket_key_prefix = var.aws_environment

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
    }
  }
}
