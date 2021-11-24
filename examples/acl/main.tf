#####################################################
# Network ACL Configuration
# Copyright 2020 IBM
#####################################################

data "ibm_is_vpc" "vpc_ds" {
  count = var.create_vpc ? 0 : 1
  name  = var.vpc_name
}

data "ibm_resource_group" "resource_group" {
  name = var.resource_group != null ? var.resource_group : "default"
}

locals {
  rules = [
    for r in var.rules : {
      name        = r.name
      action      = r.action
      source      = r.source
      destination = r.destination
      direction   = r.direction
      icmp        = lookup(r, "icmp", null)
      tcp         = lookup(r, "tcp", null)
      udp         = lookup(r, "udp", null)
    }
  ]
}

module "network_acl" {
  source = "../../"

  create_vpc     = var.create_vpc
  vpc_name       = var.vpc_name
  enable_acl     = var.enable_acl
  acl_name       = var.name
  resource_group = data.ibm_resource_group.resource_group.id
  acl_rules      = local.rules
  acl_tags       = var.tags
}