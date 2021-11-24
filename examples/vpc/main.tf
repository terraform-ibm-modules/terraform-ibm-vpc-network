#####################################################
# VPC Configuration
# Copyright 2020 IBM
#####################################################

provider "ibm" {
  region = var.region
}

data "ibm_resource_group" "resource_group" {
  name = (var.resource_group != null ? var.resource_group : "default")
}

module "vpc" {
  source = "../../"

  create_vpc                  = var.create_vpc
  vpc_name                    = var.vpc_name
  resource_group              = data.ibm_resource_group.resource_group.id
  classic_access              = var.classic_access
  default_address_prefix      = var.default_address_prefix
  default_network_acl_name    = var.default_network_acl_name
  default_security_group_name = var.default_security_group_name
  default_routing_table_name  = var.default_routing_table_name
  vpc_tags                    = var.vpc_tags
  region                      = var.region
  unique_subnet_prefix        = var.unique_subnet_prefix
  enable_gateway              = var.create_gateway
  floating_ip                 = var.floating_ip
  gateway_tags                = var.gateway_tags
}