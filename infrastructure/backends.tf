terraform {
  backend "azurerm" {
    resource_group_name  = "dullahan-resources"
    storage_account_name = "dullahanstorer"
    container_name       = "dullahan-terraform-state"
    key                  = "terraform.tfstate"
  }
}
