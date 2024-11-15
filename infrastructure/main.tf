resource "azurerm_resource_group" "main" {
  name     = "${var.resource_prefix}-resources"
  location = var.location
}

resource "azurerm_availability_set" "main" {
  name                = "${var.resource_prefix}-availability-set"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.resource_prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "main" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "main" {
  name                = "${var.resource_prefix}-public-ip"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

// Allow inbound SSH traffic.
resource "azurerm_network_security_group" "main" {
  name                = "${var.resource_prefix}-network-security-group"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "main" {
  name                = "${var.resource_prefix}-network-interface"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = azurerm_subnet.main.name
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

# Connect the security group to the network interface.
resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_linux_virtual_machine" "main" {
  name                  = "${var.resource_prefix}-virtual-machine"
  resource_group_name   = azurerm_resource_group.main.name
  location              = azurerm_resource_group.main.location
  size                  = var.virtual_machine_size
  network_interface_ids = [azurerm_network_interface.main.id]
  computer_name         = var.hostname
  admin_username        = var.username

  admin_ssh_key {
    username   = var.username
    public_key = file(var.ssh_public_key)
  }

  os_disk {
    name                 = "${var.resource_prefix}-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.virtual_machine_image.publisher
    offer     = var.virtual_machine_image.offer
    version   = var.virtual_machine_image.version
    sku       = var.virtual_machine_image.sku
  }
}
