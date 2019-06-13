provider "azurerm" {
  
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

variable "subscription_id" {
  description = "Enter Subscription ID"
}

variable "client_id" {
  description = "Enter Client ID"
}

variable "client_secret" {
  description = "Enter client_secret"
}

variable "tenant_id" {
  description = "Enter tenant ID"
}

variable "resource_group_name" {
  description = "name of rg"
}

variable "location" {
  description = "name of location"
}

variable "vnet_cidr" {
  description = "cidr of vnet"
}

variable "subnet1" {
  description = "subnet info"
}

variable "subnet2" {
  description = "subnet info"
}

variable "vnet_name" {
  description ="name of the vnet"
}

variable "vm_username" {
  description = "Enter admin username to SSH into Linux VM"
}

variable "vm_pwd" {
  description = "Enter admin password to SSH into VM"
}

variable "prefix" {
  default = "tf"
}
