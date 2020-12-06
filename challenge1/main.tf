module "vpc" {
  source                   = "terraform-aws-modules/vpc/aws"
  version                  = "2.64.0"
  name                     = "${var.aws_environment}-${var.aws_region}"
  cidr                     = var.vpc_cidr_address
  default_network_acl_name = "${var.aws_environment}-${var.aws_region}-nacl-default"
  azs                      = var.vpc_subnet_azs
  private_subnets          = var.vpc_private_subnet_cidrs
  public_subnets           = var.vpc_public_subnet_cidrs
  enable_nat_gateway       = var.enable_nat_gateway

  enable_dns_hostnames     = true
  enable_dynamodb_endpoint = true
  enable_s3_endpoint       = true

  # Common and component specific resource tags e.g role, Name etc
  tags                     = local.tags["tags_shared_by_all_components"]
  vpc_tags                 = local.tags["component_specific_tags"]["vpc_tags"]
  igw_tags                 = local.tags["component_specific_tags"]["internet_gateway_tags"]
  public_subnet_tags       = local.tags["component_specific_tags"]["public_subnet_tags"]
  private_subnet_tags      = local.tags["component_specific_tags"]["private_subnet_tags"]
  nat_gateway_tags         = local.tags["component_specific_tags"]["nat_gateway_tags"]
  private_route_table_tags = local.tags["component_specific_tags"]["route_table_tags"]
  public_route_table_tags  = local.tags["component_specific_tags"]["route_table_tags"]
}

resource "aws_instance" "web_server" {
  count                  = var.web_server_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = element(module.vpc.private_subnets, count.index)

  root_block_device {
    volume_type = var.root_volume_type
    volume_size = var.root_volume_size
  }

  tags = merge({
    Name        = format("%s-%d", "${var.aws_environment}-${var.aws_region}-web-server-node", count.index + 1)
    role        = local.tags.component_specific_tags.web_server_tags.role
  }, local.tags.tags_shared_by_all_components)

  volume_tags = merge({
    Name      = format("%s-%d", "${var.aws_environment}-${var.aws_region}-ebs-root-volume-web-server-node", count.index + 1)
    role      = local.tags.component_specific_tags.root_volume_tags.role
  }, local.tags.tags_shared_by_all_components)
}

resource "aws_instance" "app_server" {
  count                  = var.app_server_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = element(module.vpc.private_subnets, count.index)

  root_block_device {
    volume_type = var.root_volume_type
    volume_size = var.root_volume_size
  }

  tags = merge({
    Name        = format("%s-%d", "${var.aws_environment}-${var.aws_region}-app-server-node", count.index + 1)
    role        = local.tags.component_specific_tags.app_server_tags.role
  }, local.tags.tags_shared_by_all_components)

  volume_tags = merge({
    Name      = format("%s-%d", "${var.aws_environment}-${var.aws_region}-ebs-root-volume-app-server-node", count.index + 1)
    role      = local.tags.component_specific_tags.root_volume_tags.role
  }, local.tags.tags_shared_by_all_components)
}
