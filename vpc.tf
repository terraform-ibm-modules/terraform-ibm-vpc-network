#####################################################
# VPC Network Resources Configuration
# Copyright 2020 IBM
#####################################################

provider "ibm" {
  region = var.region
}

data "ibm_is_vpc" "vpc_ds" {
  count = var.create_vpc ? 0 : 1
  name  = var.vpc_name
}

data "ibm_resource_group" "resource_group" {
  name = var.resource_group != null ? var.resource_group : "default"
}

resource "ibm_is_vpc" "vpc" {
  count                       = var.create_vpc ? 1 : 0
  name                        = var.vpc_name
  resource_group              = data.ibm_resource_group.resource_group.id
  classic_access              = (var.classic_access != null ? var.classic_access : false)
  address_prefix_management   = (var.default_address_prefix != null ? var.default_address_prefix : "auto")
  default_network_acl_name    = (var.default_network_acl_name != null ? var.default_network_acl_name : null)
  default_security_group_name = (var.default_security_group_name != null ? var.default_security_group_name : null)
  default_routing_table_name  = (var.default_routing_table_name != null ? var.default_routing_table_name : null)
  tags                        = (var.vpc_tags != null ? var.vpc_tags : [])
}

#####################################################
# Create Routes
#####################################################

resource "ibm_is_vpc_routing_table" "routing_tables" {
  for_each                      = { for r in var.routing_table_list : r.name => r }
  vpc                           = var.create_vpc ? ibm_is_vpc.vpc[0].id : data.ibm_is_vpc.vpc_ds.0.id
  route_direct_link_ingress     = lookup(each.value, "route_direct_link_ingress", null)
  route_transit_gateway_ingress = lookup(each.value, "route_transit_gateway_ingress", null)
  route_vpc_zone_ingress        = lookup(each.value, "route_vpc_zone_ingress", null)
  name                          = each.value["name"]
}

resource "ibm_is_vpc_routing_table_route" "custom_routes" {
  for_each      = { for r in local.routing_table_route_list : r.name => r }
  vpc           = var.create_vpc ? ibm_is_vpc.vpc[0].id : data.ibm_is_vpc.vpc_ds.0.id
  routing_table = ibm_is_vpc_routing_table.routing_tables[each.value["routing_table_name"]].id
  name          = each.value["name"]
  zone          = each.value["location"]
  next_hop      = each.value["next_hop"]
  action        = lookup(each.value, "action", null)
  destination   = lookup(each.value, "destination", null) != null ? ibm_is_subnet.subnets[each.value["subnet_name"]].ipv4_cidr_block : null
}

#####################################################
# Create Public Gateways
#####################################################

resource "ibm_is_public_gateway" "public_gateways" {
  count          = var.enable_gateway ? 3 : 0
  name           = "${var.unique_subnet_prefix}-gateway-${count.index + 1}"
  resource_group = data.ibm_resource_group.resource_group.id
  vpc            = var.create_vpc ? ibm_is_vpc.vpc[0].id : data.ibm_is_vpc.vpc_ds.0.id
  zone           = "${var.region}-${count.index + 1}"
  floating_ip    = (length(var.floating_ip) == 1 ? var.floating_ip : {})
  tags           = var.gateway_tags
}