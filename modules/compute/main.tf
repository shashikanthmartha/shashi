resource "azurerm_availability_set" "web_availabilty_set" {
  name                = "web_availabilty_set"
  location            = var.location
  resource_group_name = var.resource_group
}

resource "azurerm_network_interface" "web-net-interface" {
  name = "web-network"
  resource_group_name = var.resource_group
  location = var.location

  ip_configuration {
    name                          = "web-webserver"
    subnet_id                     = var.web_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web_public_ip.id
  }
}

resource "azurerm_public_ip" "web_public_ip" {
  name                = "web-public-ip"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
}

resource "azurerm_virtual_machine" "web-vm" {
  name = "web-vm"
  location = var.location
  resource_group_name = var.resource_group
  network_interface_ids = [ azurerm_network_interface.web-net-interface.id ]
  availability_set_id = azurerm_availability_set.web_availabilty_set.id
  vm_size = "Standard_D2s_v3"
  delete_os_disk_on_termination = true
  
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name = "web-disk"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name = var.web_host_name
    admin_username = var.web_username
    admin_password = var.web_os_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
  
  
  resource "azurerm_availability_set" "app_availabilty_set" {
  name                = "app_availabilty_set"
  location            = var.location
  resource_group_name = var.resource_group
 }

resource "azurerm_network_interface" "app-net-interface" {
    name = "app-network"
    resource_group_name = var.resource_group
    location = var.location

    ip_configuration{
        name = "app-webserver"
        subnet_id = var.app_subnet_id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_virtual_machine" "app-vm" {
  name = "app-vm"
  location = var.location
  resource_group_name = var.resource_group
  network_interface_ids = [ azurerm_network_interface.app-net-interface.id ]
  availability_set_id = azurerm_availability_set.web_availabilty_set.id
  vm_size = "Standard_D2s_v3"
  delete_os_disk_on_termination = true
  
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name = "app-disk"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name = var.web_host_name
    admin_username = var.web_username
    admin_password = var.web_os_password
    custom_data = base64encode(<<-EOF
                  #cloud-config
                  package_update: true
                  package_upgrade: true
                  packages:
                    - nginx
                  write_files:
                    - path: /var/www/html/index.html
                      content: |
                        <html>
                        <head>
                          <title>Welcome to app-vm</title>
                        </head>
                        <body>
                          <h1>Hello, World!</h1>
                          <p>This is the index.html file deployed via Terraform.</p>
                        </body>
                        </html>
                  runcmd:
                    - systemctl enable nginx
                    - systemctl start nginx
                  EOF
                )
  }


  os_profile_linux_config {
    disable_password_authentication = false
  }
}

