output "vpc_name" {
  value       = module.vpc.name
  description = "The name of the VPC"
}

output "vpc_arn" {
  value       = module.vpc.vpc_arn
  description = "The Amazon Resource Name (ARN) of the VPC"
}

output "nat_gateway_id" {
  value       = module.vpc.natgw_ids
  description = "The ID of the NAT Gateway"
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnets
  description = "The IDs of the public subnets"
}

output "public_subnet_arns" {
  value       = module.vpc.public_subnet_arns
  description = "The arns of the public subnets"
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnets
  description = "The IDs of the private subnets"
}

output "private_subnet_arns" {
  value       = module.vpc.private_subnet_arns
  description = "The Amazon Resource Names (ARN) of the private subnets"
}

output "subnet_azs" {
  value       = module.vpc.azs
  description = "The list of availability zones which the subnets span across"
}

output "web_server_securitygroup_id" {
  description = "The security group id of the web server instance"
  value       = aws_instance.web_server.*.vpc_security_group_ids
}

output "web_server_instance_id" {
  description = "The instance id of the web_server instance"
  value       = aws_instance.web_server.*.id
}

output "web_server_private_ip_address" {
  description = "The private IP address of the web_server instance"
  value       = aws_instance.web_server.*.private_ip
}
