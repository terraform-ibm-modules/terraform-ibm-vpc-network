#  IBM Cloud terraform-ibm-vpc-network - Terraform Module
Terraform Module Repository which creates IBM VPC Network infrastructure

This module a collection of modules that make it easier to provision VPC Network resources.

## Compatibility

This module is meant for use with Terraform 0.13 (and higher).

## Requirements

### Terraform plugins

- [Terraform](https://www.terraform.io/downloads.html) 0.13 (or later)
- [terraform-provider-ibm](https://github.com/IBM-Cloud/terraform-provider-ibm)

## Install

### Terraform

Be sure you have the correct Terraform version (0.13), you can choose the binary here:
- https://releases.hashicorp.com/terraform/

### Terraform plugins

Be sure you have the compiled plugins on $HOME/.terraform.d/plugins/

- [terraform-provider-ibm](https://github.com/IBM-Cloud/terraform-provider-ibm)

### Pre-commit hooks

Run the following command to execute the pre-commit hooks defined in .pre-commit-config.yaml file
```
pre-commit run -a
```
You can install pre-coomit tool using

```
pip install pre-commit
```
or
```
pip3 install pre-commit
```
## How to input variable values through a file

To review the plan for the configuration defined (no resources actually provisioned)
```
terraform plan -var-file=./input.tfvars
```
To execute and start building the configuration defined in the plan (provisions resources)
```
terraform apply -var-file=./input.tfvars
```

To destroy the VPC and all related resources
```
terraform destroy -var-file=./input.tfvars
```

## Note

All optional parameters, by default, will be set to `null` in respective example's variable.tf file. You can also override these optional parameters.

## Inputs

| Name                              | Description                                           | Type   | Default | Required |
|-----------------------------------|-------------------------------------------------------|--------|---------|----------|
| create\_vpc | True to create new VPC. False if VPC is already existing and subnets, gateways are to be added to it | bool | n/a | yes |
| vpc\_name | Name of the vpc. Required only if Creating a new VPC | string | n/a | yes |
| region | Region in which resources are to be created | string | "us-south" | no |
| resource\_group | Name of the resource group | string | n/a | no |
| classic\_access | Indicates whether this VPC should be connected to Classic Infrastructure. | bool | false | no |
| default\_address\_prefix | Indicates whether a default address prefix should be automatically created for each zone in this VPC.  | string | auto | no |
| default\_network\_acl\_name | Name of the Default ACL of the VPC | string | n/a | no |
| default\_security\_group\_name | Name of the Default Security Group of the VPC | string | n/a | no |
| default\_routing\_table\_name | Name of the Default Routing Table of the VPC  | string | n/a | no |
| vpc\_tags | List of tags to attach to the VPC | list(string) | n/a | no |
| routing\_table\_list | List of Routing tables | list(object) | n/a | no |
| enable\_gateway | True to create new Public Gateways | bool | false | no |
| floating\_ip | Floating IP `id` or `address` that you want to assign to the public gateway | map | n/a | no |
| gateway\_tags | List of Tags for the gateway | list(string) | n/a | no |
| unique\_subnet\_prefix | Name(or Prefix) of the Subnet(s). Required only while Creating a new subnet(s) | string | n/a | no |
| cidr\_blocks | CIDR blocks for subnets to be created and whether or not they are default to the subnet's zone. If no CIDR blocks are provided, it will create subnets with 256 total ipv4 addresses | list(string) | ["10.10.10.0/24,false", "10.10.11.0/24,", "10.10.12.0/24,"] | no |
| subnets\_per\_zone | Number of subnets per zone | number | 1 | no |
| number\_of\_zones | Number of zones to deploy subnets in | number | 3 | no |
| total\_ipv4\_address\_count | Number of IPV4 Addresses. Required only while Creating a new subnet(s) | number | 256 | no |
| ip\_version | IP Version of the subnets  | string | n/a | no |
| subnet\_tags | A list of tags to be applied to subnets | list(string) | n/a | no |
| access\_tags | A list of access management tags of subnets | list(string) | n/a | no |
| enable\acl | True to create new ACL | bool | false | no |
| acl\_name | Name of the Network ACL | string | n/a | yes |
| acl\_rules | List of Network ACL Rules that are to be attached to the ACL  | list(object) | n/a | no |
| acl\_tags | List of tags to attach to ACL | list(string) | n/a | no |


## Outputs

| Name | Description |
|------|-------------|
| vpc\_id | The ID of the VPC |
| vpc\_default\_security\_group |The ID of the vpc default security group |
| vpc\_default\_network\_acl | The ID of the vpc default network acl |
| vpc\_default\_routing\_table | The ID of the vpc default Routing Table |
| vpc\_address\_prefixes | The ID(s) of the Address Prefixes to VPC |
| vpc\_address\_prefixes\_cidr | The Address Prefix CIDRs of the VPC |
| subnet\_ids | The ID(s) of the Subnet(s) |
| subnet\_ipv4\_cidrs | IPV4 subnet CIDR blocks |
| public\_gateway\_ids | The ID(s) of the Public Gateway(s) |
| network\_acl\_id | The ID of the Network ACL |