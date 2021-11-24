#####################################################
# VPC
# Copyright 2020 IBM
#####################################################

variable "create_vpc" {
  description = "True to create new VPC. False if VPC is already existing and subnets or address prefixies are to be added"
  type        = bool
}

#####################################################
# Optional Parameters
#####################################################

variable "vpc_name" {
  description = "Name of the vpc"
  type        = string
}

variable "region" {
  description = "Region for resources to be created"
  type        = string
  default     = "us-south"
}

variable "unique_subnet_prefix" {
  description = "Unique prefix for the network resources"
  type        = string
  default     = "example"
}

variable "resource_group" {
  description = "Resource group name"
  type        = string
  default     = null
}

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
  description = "List of tags."
  type        = list(string)
  default     = null
}

variable "locations" {
  description = "zones per region"
  type        = list(string)
  default     = []
}

variable "subnet_name_prefix" {
  description = "Name of the subnet"
  type        = string
  default     = null
}

variable "routing_table" {
  description = "Routing Table ID"
  type        = string
  default     = null
}

variable "create_gateway" {
  description = "True to create new Gateway"
  type        = bool
  default     = true
}

variable "public_gateway_name_prefix" {
  description = "Prefix to the names of Public Gateways"
  type        = string
  default     = null
}

variable "floating_ip" {
  description = "Floating IP `id`'s or `address`'es that you want to assign to the public gateway"
  type        = map
  default     = {}
}

variable "gateway_tags" {
  description = "List of Tags for the gateway"
  type        = list(string)
  default     = null
}