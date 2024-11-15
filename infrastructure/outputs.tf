output "ip_address" {
  value       = azurerm_public_ip.main.ip_address
  depends_on  = [azurerm_public_ip.main]
  description = "The public IP address of the virtual machine."
}
