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
  # Required by terraform
  dynamic "access_policy" {
    for_each    = local.access_policies

    content {
      tenant_id    = coalesce(access_policy.value.tenant_id, data.azurerm_client_config.current.tenant_id)
      object_id    = access_policy.value.object_id

      key_permissions = coalescelist(access_policy.value.key_permissions, local.default_key_permissions)
      certificate_permissions = coalescelist(access_policy.value.certificate_permissions, local.default_certificate_permissions)
      storage_permissions = coalescelist(access_policy.value.storage_permissions, local.default_storage_permissions)
      secret_permissions = coalescelist(access_policy.value.secret_permissions, local.default_secret_permissions)
    }
  }
  
  tags = local.tags
}