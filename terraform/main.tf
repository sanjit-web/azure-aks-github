provider "azurerm" {
  features {}
  subscription_id = "e037b35a-77b0-41f3-96f0-ec1b908f17f6"
}

resource "azurerm_resource_group" "rg" {
  name     = "shopping-rg"
  location = "East US"
}

resource "azurerm_container_registry" "acr" {
  name                = "shoppingacr123"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "shopping-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "shopping"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DC2s_v3"
  }

  identity {
    type = "SystemAssigned"
  }
}

