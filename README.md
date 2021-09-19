# terraform-ibm-vpc-network
Terraform Module Repository which creates IBM VPC Network infrastructure

Root Module consists of all VPC Network resources.

Scenarios to construct sub-modules

1. Most commonly used basic VPC infrastructure which consists of a vpc, it's child resources and subnets
2. Allowing public Gateway access to the VPC Zones.
3. Attach flow logs to a vpc/subnet/instance
4. Network Security which includes creation of Security groups, Network ACLs, VPNs
5. Load Balancing
6. Private Endpoint creation on VPC 
