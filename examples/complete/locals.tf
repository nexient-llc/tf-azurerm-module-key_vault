locals {
  name                = "${var.naming_prefix}-kv-${random_integer.priority.result}"
  resource_group_name = "${var.naming_prefix}-rg-${random_integer.priority.result}"
  tags                = merge(var.tags, { provisioner = "Terraform" })
}