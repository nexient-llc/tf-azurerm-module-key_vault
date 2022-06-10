locals {
	default_tags = {
		"provisioner": "Terraform"
	}

	tags = merge(local.default_tags, var.custom_tags)

	default_certificate_permissions = ["List"]

	default_key_permissions = ["List"]

	default_secret_permissions = ["List"]

	default_storage_permissions = ["List"]
}