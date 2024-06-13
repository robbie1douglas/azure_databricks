resource "azurerm_network_security_group" "this_nsg" {
  location            = azurerm_resource_group.this.location
  name                = "${lower(var.client_name)}-${lower(var.project_name)}-nsg"
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_route_table" "this_rt" {
  location            = azurerm_resource_group.this.location
  name                = "${lower(var.client_name)}-${lower(var.project_name)}-rt"
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_virtual_network" "this_vnet" {
  name                = "${lower(var.client_name)}-${lower(var.project_name)}-vnet"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = [var.vnet_cidr]

  tags = var.tags
}

resource "azurerm_network_security_group" "this_databricks_nsg" {
  location            = azurerm_resource_group.this.location
  name                = "${lower(var.client_name)}-${lower(var.project_name)}-databricks-nsg"
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_subnet" "this_se_subnet" {
  name                 = "${lower(var.client_name)}-${lower(var.project_name)}-se-subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this_vnet.name
  address_prefixes     = [var.se_subnet_cidr != "" ? var.se_subnet_cidr : cidrsubnet(var.vnet_cidr, 8, 0)]
  service_endpoints    = ["Microsoft.KeyVault"]
}

resource "azurerm_subnet_route_table_association" "this_se_rtb_association" {
  route_table_id = azurerm_route_table.this_rt.id
  subnet_id      = azurerm_subnet.this_se_subnet.id
}

resource "azurerm_subnet_network_security_group_association" "this_se_nsg_association" {
  network_security_group_id = azurerm_network_security_group.this_nsg.id
  subnet_id                 = azurerm_subnet.this_se_subnet.id
}

resource "azurerm_subnet" "this_databricks_public_subnet" {
  name                 = "${lower(var.client_name)}-${lower(var.project_name)}-databricks-pub-subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this_vnet.name
  address_prefixes     = [var.databricks_public_subnet_cidr != "" ? var.databricks_public_subnet_cidr : cidrsubnet(var.vnet_cidr, 10, 4)]
  service_endpoints    = ["Microsoft.KeyVault"]

  delegation {
    name = "delegation"

    service_delegation {
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
      ]
      name = "Microsoft.Databricks/workspaces"
    }
  }

  lifecycle {
    ignore_changes = [
      delegation,
    ]
  }
}

resource "azurerm_subnet_route_table_association" "this_databricks_public_rtb_association" {
  route_table_id = azurerm_route_table.this_rt.id
  subnet_id      = azurerm_subnet.this_databricks_public_subnet.id
}

resource "azurerm_subnet_network_security_group_association" "this_databricks_public_nsg_association" {
  network_security_group_id = azurerm_network_security_group.this_databricks_nsg.id
  subnet_id                 = azurerm_subnet.this_databricks_public_subnet.id
}


resource "azurerm_subnet" "this_databricks_private_subnet" {
  name                 = "${lower(var.client_name)}-${lower(var.project_name)}-databricks-prv-subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this_vnet.name
  address_prefixes     = [var.databricks_private_subnet_cidr != "" ? var.databricks_private_subnet_cidr : cidrsubnet(var.vnet_cidr, 10, 5)]
  service_endpoints    = ["Microsoft.KeyVault"]

  delegation {
    name = "delegation"

    service_delegation {
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
      ]
      name = "Microsoft.Databricks/workspaces"
    }
  }

  lifecycle {
    ignore_changes = [
      delegation,
    ]
  }
}

resource "azurerm_subnet_route_table_association" "this_databricks_private_rtb_association" {
  route_table_id = azurerm_route_table.this_rt.id
  subnet_id      = azurerm_subnet.this_databricks_private_subnet.id
}

resource "azurerm_subnet_network_security_group_association" "this_databricks_private_nsg_association" {
  network_security_group_id = azurerm_network_security_group.this_databricks_nsg.id
  subnet_id                 = azurerm_subnet.this_databricks_private_subnet.id
}

resource "azurerm_private_dns_zone" "this" {
  name                = "privatelink.azuredatabricks.net"
  resource_group_name = azurerm_resource_group.this.name
}
