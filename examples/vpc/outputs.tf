#####################################################
# VPC Outputs Configuration
# Copyright 2020 IBM
#####################################################

output "vpc_id" {
  description = "The ID of the vpc"
  value       = module.vpc.vpc_id
}

output "vpc_default_security_group" {
  description = "The ID of the vpc default security group"
  value       = module.vpc.vpc_default_security_group
}

output "vpc_default_network_acl" {
  description = "The ID of the vpc default network acl"
  value       = module.vpc.vpc_default_network_acl
}

output "vpc_default_routing_table" {
  description = "The ID of the vpc default Routing Table"
  value       = module.vpc.vpc_default_routing_table
}

output "public_gateway_ids" {
  description = "The IDs of the Public Gateways"
  value       = module.vpc.public_gateway_ids
}