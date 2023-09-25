locals{
  clusters_name= ["jade","sajeevan","paul","douglas","emannuel","olarewaju","oladi"]
}

resource "azurerm_kubernetes_cluster" "k8s" {
  for_each            = { for cluster in local.clusters_name : cluster => cluster }
  name                = "k8s-${var.convention}-${each.key}"
  location            = azurerm_resource_group.azureresourcegroup.location
  resource_group_name = azurerm_resource_group.azureresourcegroup.name
  dns_prefix          = "${var.prefix}-k8s"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}
