locals {
	default_tags = {
		"provisioner": "Terraform"
	}

	tags = merge(local.default_tags, var.custom_tags)

	default_certificate_permissions = ["List"]

	default_key_permissions = ["List"]

	default_secret_permissions = ["List"]

	default_storage_permissions = ["List"]

	default_access_policy = {
		"default_policy"     = {
      object_id     = data.azurerm_client_config.current.object_id
      tenant_id     = data.azurerm_client_config.current.tenant_id
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
	}

	access_policies = merge(local.default_access_policy, var.access_policies)
}