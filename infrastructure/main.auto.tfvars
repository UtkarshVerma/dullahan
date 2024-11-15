resource_prefix = "dullahan"
location        = "westeurope"
hostname        = "dullahan"
username        = "subaru"
ssh_public_key  = "~/.ssh/dullahan.pub"
subscription_id = "c49c32cb-e15c-49cd-9a43-5999e3b72564"

# https://documentation.ubuntu.com/azure/en/latest/azure-how-to/instances/find-ubuntu-images/
virtual_machine_size = "Standard_B2pts_v2"
virtual_machine_image = {
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-jammy"
  sku       = "22_04-lts-arm64"
  version   = "latest"
}
