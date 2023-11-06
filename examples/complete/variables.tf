// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

variable "location" {
  description = "(Required) The Azure Region where the Resource Group and storage Account should exist. Changing this forces a new Resource Group and storage Account to be created."
  type        = string
  default     = "EastUS"
}

variable "tags" {
  description = "(Optional) A mapping of tags which should be assigned to the Storage Account."
  type        = map(string)
  default     = {}
}

variable "naming_prefix" {
  description = "Prefix for the provisioned resources."
  type        = string
  default     = "platform"
}

variable "managed_by" {
  description = "(Optional) The ID of the resource that manages this resource group."
  type        = string
  default     = null

}

variable "sku_name" {
  description = "SKU for the key vault - standard or premium"
  type        = string
  default     = "standard"
}

variable "purge_protection_enabled" {
  description = "If purge_protection is enabled"
  type        = bool
  default     = false
}

variable "enable_rbac_authorization" {
  description = "Bool Value to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions."
  type        = bool
  default     = false
}
