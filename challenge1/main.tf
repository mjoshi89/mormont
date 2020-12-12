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
  vpc_security_group_ids  = [aws_security_group.web_server_securitygroup.id]

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

resource "aws_security_group" "web_server_securitygroup" {
  name        = format("%s", "${var.aws_environment}-${var.aws_region}-sg-web-server-security-group")
  description = "Security group for the Web Server Instance"
  vpc_id      = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = local.security_group_inbound_rules
    iterator = property
    content {
      from_port   = property.value.from
      to_port     = property.value.to
      protocol    = property.value.protocol
      cidr_blocks = [property.value.access_cidr]
      description = property.value.description
    }
  }

  dynamic "egress" {
    for_each = local.security_group_outbound_rules
    iterator = property
    content {
      from_port   = property.value.from
      to_port     = property.value.to
      protocol    = property.value.protocol
      description = property.value.description
      cidr_blocks = [property.value.access_cidr]
    }
  }

  tags = merge({
    Name = format("%s", "${var.aws_environment}-${var.aws_region}-sg-web-server-security-group")
  }, local.tags.tags_shared_by_all_components)
}

/*
module "web_server_alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 5.0"

  format("%s", "${var.aws_environment}-${var.aws_region}-web-server-alb")

  load_balancer_type = "application"

  vpc_id             = module.vpc.vpc_id
  subnets            = aws_instance.web_server[*].subnet_id
  security_groups    = aws_instance.web_server.*.private_ip
  enable_cross_zone_load_balancing = true

  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    }
  ]


  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = merge({
    Name = format("%s", "${var.aws_environment}-${var.aws_region}-web-server-albp")
  }, local.tags.tags_shared_by_all_components)
}
*/
