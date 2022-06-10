locals {
    default_tags = {
        "provisioner": "Terraform"
    }

    tags = merge(local.default_tags, var.custom_tags)

    default_certificate_permissions = []

    default_key_permissions = []

    default_secret_permissions = []

    default_storage_permissions = []
}