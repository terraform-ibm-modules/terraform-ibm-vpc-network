#####################################################
# Network ACL Module Example Parameters
# Copyright 2020 IBM
#####################################################

variable "create_vpc" {
  description = "True to create new VPC. False if VPC is already existing and subnets or address prefixies are to be added"
  type        = bool
}

variable "enable_acl" {
  description = "Enables acl id if true"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of the Network ACL"
  type        = string
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

#####################################################
# Optional Parameters
#####################################################

variable "resource_group" {
  description = "Resource group name"
  type        = string
  default     = null
}

variable "rules" {
  description = "List of rules that are to be attached to the Network ACL"
  default     = []
}

variable "tags" {
  description = "List of Tags for the ACL"
  type        = list(string)
  default     = null
}