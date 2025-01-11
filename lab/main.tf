locals {
  zones = length(data.ibm_is_zones.regional.zones)
  vpc_zones = {
    for zone in range(local.zones) : zone => {
      zone = "${var.region}-${zone + 1}"
    }
  }

  tags = [
    "provider:ibm",
    "region:${var.region}"
  ]
}

# If an existing resource group is provided, this module returns the ID, otherwise it creates a new one and returns the ID
module "resource_group" {
  source                       = "terraform-ibm-modules/resource-group/ibm"
  version                      = "1.1.5"
  resource_group_name          = var.existing_resource_group_name == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.existing_resource_group_name
}

resource "ibm_is_vpc" "vpc" {
  name                        = "${var.prefix}-vpc"
  resource_group              = module.resource_group.resource_group_id
  address_prefix_management   = var.default_address_prefix
  default_network_acl_name    = "${var.prefix}-default-nacl"
  default_security_group_name = "${var.prefix}-default-sg"
  default_routing_table_name  = "${var.prefix}-default-rt"
  tags                        = local.tags
}

resource "ibm_is_public_gateway" "gateway" {
  count          = length(data.ibm_is_zones.regional.zones)
  name           = "${var.prefix}-pgw-${count.index + 1}"
  resource_group = module.resource_group.resource_group_id
  vpc            = ibm_is_vpc.vpc.id
  zone           = local.vpc_zones[count.index].zone
  tags           = concat(local.tags, ["zone:${local.vpc_zones[count.index].zone}"])
}