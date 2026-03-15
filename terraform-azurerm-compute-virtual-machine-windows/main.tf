module "publicIP" {
  source              = "../terraform-azurerm-networking-public-ip"
  count               = var.public_ip_allocation_method == "" ? 0 : 1
  name                = "${var.name}-publicIP"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.public_ip_sku
  allocation_method   = var.public_ip_allocation_method
  ip_tags             = var.public_ip_tags
  zones               = var.public_ip_zones
  tags                = {}
}

module "managedDisk" {
  source   = "../terraform-azurerm-storage-managed-disk"
  for_each = var.data_disks

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  location             = var.location
  storage_account_type = each.value.storage_account_type
  create_option        = each.value.create_option
  disk_size_gb         = each.value.disk_size_gb
  tags                 = each.value.tags
}

data "azurerm_subnet" "sn" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = coalesce(var.vnet_resource_group_name, var.resource_group_name)
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.name}-ipconfig"
    subnet_id                     = data.azurerm_subnet.sn.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_allocation_method == "" ? null : module.publicIP[0].ip.id
  }
}

resource "random_password" "pw" {
  length  = 24
  special = true
}


resource "azurerm_windows_virtual_machine" "vm" {
  depends_on = [
    azurerm_network_interface.nic,
    module.managedDisk
  ]
  name                = var.name
  tags                = var.tags
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  admin_username      = var.admin_username
  admin_password      = coalesce(var.admin_password, random_password.pw.result)
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
  }

  source_image_id = var.source_image_id

  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_account_uri
  }

  dynamic "source_image_reference" {
    for_each = var.source_image_id == null ? [1] : []
    content {
      publisher = var.source_image_reference.publisher
      offer     = var.source_image_reference.offer
      sku       = var.source_image_reference.sku
      version   = var.source_image_reference.version
    }
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_link" {
  count                     = var.linked_nsg_id == "" ? 0 : 1
  depends_on                = [azurerm_network_interface.nic]
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = var.linked_nsg_id
}

resource "azurerm_virtual_machine_data_disk_attachment" "datadisk" {
  depends_on         = [module.managedDisk]
  for_each           = var.data_disks
  managed_disk_id    = module.managedDisk[each.value.name].created_disk.id
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id
  lun                = each.value.lun_number
  caching            = "ReadWrite"
}


