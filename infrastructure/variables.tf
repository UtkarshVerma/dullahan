variable "subscription_id" {
  type        = string
  description = "Azure subscription ID."
}

variable "resource_prefix" {
  type        = string
  description = "Prefix for all resources associated with this project."
}

variable "location" {
  type        = string
  description = "Location for all resources."
}

variable "hostname" {
  type        = string
  description = "Hostname for the VM."
}

variable "username" {
  type        = string
  description = "Admin username for the VM."
}

variable "ssh_public_key" {
  type        = string
  description = "Path to SSH public key."
}

variable "virtual_machine_size" {
  type        = string
  description = "Size of the virtual machine."
}

variable "virtual_machine_image" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "Source image parameters for the virtual machine."
}
