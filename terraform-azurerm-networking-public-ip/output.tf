output "ip" {
  value     = azurerm_public_ip.ip
  sensitive = true
}