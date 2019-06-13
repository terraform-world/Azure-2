

resource "azurerm_resource_group" "test" {
    name     = "${var.resource_group_name}"
    location = "${var.location}"
 
}

resource "azurerm_virtual_network" "testvnet" {
  name = "${var.vnet_name}"
  address_space = ["${var.vnet_cidr}"]
  location = "${var.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"

}

resource "azurerm_subnet" "testsubnet" {
  name = "subnet1"
  address_prefix = "${var.subnet1}"
  virtual_network_name = "${var.vnet_name}"
  resource_group_name = "${var.resource_group_name}"
}

resource "azurerm_subnet" "testsubnet2" {
  name = "subnet2"
  address_prefix = "${var.subnet2}"
  virtual_network_name = "${var.vnet_name}"
  resource_group_name = "${var.resource_group_name}"
}


resource "azurerm_network_interface" "nic" {
  name  = "${var.prefix}-nic"
  location = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

ip_configuration {
  name  = "${var.prefix}-ipconfig"
  subnet_id = "${azurerm_subnet.testsubnet.id}"
  private_ip_address_allocation = "Dynamic"
}
}
resource "azurerm_virtual_machine" "vm" {
  name = "${var.prefix}-vm"
  location = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  network_interface_ids = ["${azurerm_network_interface.nic.id}"]
  vm_size = "standard_DS1_v2"
  

    # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true


  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "${var.vm_username}"
    admin_password = "${var.vm_pwd}"
  }
  os_profile_windows_config {
    #disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}