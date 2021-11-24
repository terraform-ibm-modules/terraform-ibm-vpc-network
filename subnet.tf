#####################################################
# Create Subnet Prefixes
#####################################################

resource "ibm_is_vpc_address_prefix" "subnet_prefix" {
  count      = length(var.cidr_blocks) > 0 ? var.subnets_per_zone * var.number_of_zones : 0
  name       = "${var.unique_subnet_prefix}-prefix${count.index + 1}-zone-${(count.index % var.number_of_zones) + 1}"
  zone       = "${var.region}-${(count.index % var.number_of_zones) + 1}"
  vpc        = var.create_vpc ? ibm_is_vpc.vpc[0].id : data.ibm_is_vpc.vpc_ds.0.id
  cidr       = split(",", element(var.cidr_blocks, count.index))[0]
  is_default = split(",", element(var.cidr_blocks, count.index))[1] == "" ? null : split(",", element(var.cidr_blocks, count.index))[1]
}


#####################################################
# Create Subnets
#####################################################


resource "ibm_is_subnet" "subnets" {
  count                    = var.subnets_per_zone * var.number_of_zones
  name                     = "${var.unique_subnet_prefix}-subnet-${count.index + 1}"
  vpc                      = var.create_vpc ? ibm_is_vpc.vpc[0].id : data.ibm_is_vpc.vpc_ds.0.id
  resource_group           = data.ibm_resource_group.resource_group.id
  zone                     = "${var.region}-${(count.index % var.number_of_zones) + 1}"
  ipv4_cidr_block          = length(var.cidr_blocks) > 0 ? element(ibm_is_vpc_address_prefix.subnet_prefix.*.cidr, count.index) : null
  total_ipv4_address_count = length(var.cidr_blocks) > 0 ? null : var.total_ipv4_address_count
  network_acl              = var.enable_acl ? ibm_is_network_acl.nwacl.0.id : null
  public_gateway           = var.enable_gateway ? element(ibm_is_public_gateway.public_gateways.*.id, count.index) : null
  //   routing_table            = var.routing_tables != null ? element(var.routing_tables, count.index) : null
  tags        = var.subnet_tags
  access_tags = var.access_tags
  ip_version  = var.ip_version
}