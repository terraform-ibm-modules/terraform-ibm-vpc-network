#####################################################
# VPC Variables
# Copyright 2020 IBM
#####################################################

variable "create_vpc" {
  description = "True to create new VPC. False if VPC is already existing and subnets or address prefixies are to be added"
  type        = bool
}

variable "vpc_name" {
  description = "Name of the vpc"
  type        = string
}

##############################################################################
# Account Variables
##############################################################################

variable "region" {
  description = "Region in which resources are to be created"
  type        = string
  default     = "us-south"
}

variable "resource_group" {
  description = "Name of resource group to create VPC. If not given, `Default` resource group will be used to create the network resources"
  type        = string
  default     = null
}


#####################################################
# Optional Parameters
#####################################################

variable "classic_access" {
  description = "Classic Access to the VPC"
  type        = bool
  default     = null
}

variable "default_address_prefix" {
  description = "Default address prefix creation method"
  type        = string
  default     = null
}

variable "default_network_acl_name" {
  description = "Name of the Default ACL"
  type        = string
  default     = null
}

variable "default_security_group_name" {
  description = "Name of the Default Security Group"
  type        = string
  default     = null
}

variable "default_routing_table_name" {
  description = "Name of the Default Routing Table"
  type        = string
  default     = null
}

variable "vpc_tags" {
  description = "List of Tags for the vpc"
  type        = list(string)
  default     = []
}

variable "routing_table_list" {
  description = "List of Routing tables"
  type = list(object({
    name                          = string
    route_direct_link_ingress     = string
    route_transit_gateway_ingress = string
    route_vpc_zone_ingress        = string
    routes = list(object({
      name        = string
      zone        = string
      next_hop    = string
      action      = string
      destination = string
    }))
  }))
  default = []
}

variable "enable_gateway" {
  description = "True to create new Gateway and enable it to subnets"
  type        = bool
  default     = false
}

variable "floating_ip" {
  description = "Floating IP `id`'s or `address`'es that you want to assign to the public gateway"
  type        = map(any)
  default     = {}
}

variable "gateway_tags" {
  description = "List of Tags for the gateway"
  type        = list(string)
  default     = []
}

##############################################################################
# Prefix variables
##############################################################################

variable "unique_subnet_prefix" {
  description = "Unique prefix for the network resources"
  type        = string
  default     = "example"
}

variable "cidr_blocks" {
  description = "CIDR blocks for subnets to be created and whether or not they are default to the subnet's zone. If no CIDR blocks are provided, it will create subnets with 256 total ipv4 addresses"
  type        = list(string)
  default     = ["10.10.10.0/24,false", "10.10.11.0/24,", "10.10.12.0/24,"]
}

##############################################################################
# Subnet variables
##############################################################################

variable "subnets_per_zone" {
  description = "Number of subnets per zone"
  type        = number
  default     = 1
}

variable "number_of_zones" {
  description = "Number of zones to deploy subnets in"
  type        = number
  default     = 3
}

variable "total_ipv4_address_count" {
  description = "The total number of IPv4 addresses in this subnet"
  type        = number
  default     = 256
}

variable "ip_version" {
  description = "IP Version"
  type        = string
  default     = null
}

// variable routing_tables {
//   description = "List of Routing table ids"
//   type        = list(string)
//   default     = []
// }

variable "subnet_tags" {
  description = "A list of tags to be applied to subnets"
  type        = list(string)
  default     = []
}

variable "access_tags" {
  description = "A list of access management tags of subnets"
  type        = list(string)
  default     = []
}

#####################################################
# Network ACL Parameters
#####################################################

variable "enable_acl" {
  description = "Enables acl id if true"
  type        = bool
  default     = false
}

variable "acl_name" {
  description = "Name of the Network ACL"
  type        = string
  default     = null
}

variable "acl_rules" {
  description = "List of rules that are to be attached to the Network ACL"
  type = list(object({
    name        = string
    action      = string
    source      = string
    destination = string
    direction   = string
    icmp = object({
      code = number
      type = number
    })
    tcp = object({
      port_max        = number
      port_min        = number
      source_port_max = number
      source_port_min = number
    })
    udp = object({
      port_max        = number
      port_min        = number
      source_port_max = number
      source_port_min = number
    })
  }))
  default = []
}

variable "acl_tags" {
  description = "List of Tags for the ACL"
  type        = list(string)
  default     = null
}