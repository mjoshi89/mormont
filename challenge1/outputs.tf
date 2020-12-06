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
