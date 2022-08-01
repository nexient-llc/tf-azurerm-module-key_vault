output "key_vault_id" {
	value = azurerm_key_vault.key_vault.id
}

output "vault_uri" {
	value = azurerm_key_vault.key_vault.vault_uri
}

output "access_policies_object_ids" {
	value = try(azurerm_key_vault.key_vault.access_policy[*].object_id)
}

output "key_vault_name" {
	value = azurerm_key_vault.key_vault.name
}

output "certificate_ids" {
	value = [
		for cert in azurerm_key_vault_certificate.certs : cert.id
	]
	sensitive = false
}

output "secret_ids" {
	value = [
		for secret in azurerm_key_vault_secret.vault_secrets : secret.id
	]
	sensitive = false
}

output "key_ids" {
	value = [
		for key in azurerm_key_vault_key.vault_keys : key.id
	]
	sensitive = false
}