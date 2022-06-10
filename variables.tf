#########################################
# Common variables
#########################################

variable "resource_group" {
  description = "target resource group resource mask"
  type = object({
    name     = string
    location = string
  })
}

#########################################
# Variables related to Key Vault
#########################################

variable "key_vault_name" {
    description = "Name of the key vault"
    type = string
}

variable "enabled_for_deployment" {
    description = "If Azure VM is permitted to retrieve secrets"
    type = bool
    default = false
}

variable "enabled_for_template_deployment" {
    description = "If Azure RM is permitted to retrieve secrets"
    type = bool
    default = false
}

variable "soft_delete_retention_days" {
    description = "Number of retention days for soft delete"
    type = number
    default = 7
}

variable "purge_protection_enabled" {
    description = "If purge_protection is enabled"
    type = bool
    default = false
}

variable "sku_name" {
    description = "SKU for the key vault - standard or premium"
    type = string
    default = "standard"
}

variable "custom_tags" {
    description = "Custom tags for the Key vault"
    type = map(string)
    default = {}
}



