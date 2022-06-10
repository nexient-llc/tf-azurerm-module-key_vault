data "azurerm_client_config" "current" {

}

resource "azurerm_key_vault" "key_vault" {
  name                            = var.key_vault_name
  location                        = var.resource_group.location
  resource_group_name             = var.resource_group.name
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_template_deployment = var.enabled_for_template_deployment
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days      = var.soft_delete_retention_days
  purge_protection_enabled        = var.purge_protection_enabled
  sku_name                        = var.sku_name
  
  # Provide permission to dsahoo@nexient.com
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    certificate_permissions = [
      "Get", "List", "Import", "Update", "ListIssuers", "GetIssuers", "Delete", "Recover", "Purge"
    ]

    key_permissions = [
      "Get", "List", "Delete", "Create"
    ]

    secret_permissions = [
      "Get", "List", "Delete", "Set"
    ]

    storage_permissions = [
      "Get", "List", "Delete", "Set"
    ]
  }

  tags = local.tags
}

resource "azurerm_key_vault_access_policy" "access_policy" {

  for_each      = var.access_policies

  key_vault_id = azurerm_key_vault.key_vault.id
  tenant_id    = coalesce(each.value.tenant_id, data.azurerm_client_config.current.tenant_id)
  object_id    = each.value.object_id

  key_permissions = coalescelist(each.value.key_permissions, local.default_key_permissions)
  certificate_permissions = coalescelist(each.value.certificate_permissions, local.default_certificate_permissions)
  storage_permissions = coalescelist(each.value.storage_permissions, local.default_storage_permissions)
  secret_permissions = coalescelist(each.value.secret_permissions, local.default_secret_permissions)

}