variable "aws_environment" {
  description = "The name of the environment deploying into"
  type        = string
}

variable "aws_region" {
  description = "The AWS region deploying into"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "vpc_cidr_address" {
  description = "The CIDR address allocated to the VPC"
  type        = string
}

variable "vpc_subnet_azs" {
  description = "A list of availability zones for the public and private subnets"
  type        = list(string)
}

variable "vpc_private_subnet_cidrs" {
  description = "A list of availability zones for the public and private subnets"
  type        = list(string)
}

variable "vpc_public_subnet_cidrs" {
  description = "A list of availability zones for the public and private subnets"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Crete a NAT gateway for the private subnets"
  type        = bool
  default     = true
}

variable "ami_id" {
  description = "AMI ID to be used for server creation"
  type        = string
}

variable "root_volume_type" {
  type        = string
  description = "The type of the root type"
}

variable "root_volume_size" {
  type        = string
  description = "The size of the root volume"
}

variable "instance_type" {
  type        = string
  description = "The instace type of the web and app servers"
}

variable "app_server_count" {
  type        = number
  description = "Number of App servers"
}

variable "web_server_count" {
  type        = number
  description = "Number of Web servers"
}

variable "db_instance_type" {
  type        = string
  description = "The instace type of the database server"
}

variable "db_volume_size" {
  type        = string
  description = "The size of the database volume"
}

variable "db_engine" {
  type        = string
  description = "The type of the database engine"
}

variable "db_version" {
  type        = string
  description = "The version of the database"
}

variable "db_username" {
  type        = string
  description = "The username for the database"
}

variable "db_password" {
  type        = string
  description = "The password for the database"
}

variable "db_family" {
  type        = string
  description = "The family for the database"
}

variable "db_major_engine_version" {
  type        = string
  description = "The major engine for the database"
}
