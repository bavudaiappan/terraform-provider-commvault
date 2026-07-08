---
page_title: "Provider: commvault"
subcategory: ""
description: |-
  The Commvault Terraform Provider interacts with the commvault REST API's for CRED Operations.
---

# Commvault Terraform Provider

With the Commvault Terraform provider, you can use Terraform to manage endpoints (called resources). Terraform is a configuration language for safely and efficiently managing infrastructure.

The Commvault Terraform provider provides a set of named resource types, and specifies which arguments are allowed for each resource type. Using the resource types, you can create a configuration file, and apply changes to the Commvault REST APIs. For example, you can use the commvault_user resource type to add and delete users in your CommCell environment.


## Syntax
```
provider "commvault" {
	web_service_url = "URL of the commserver webservice/webconsole api endpoint"
	user_name = "username that is used to call APIs"
	password = "password in base 64 encoded format"
	api_token = "access token to be used"
	refresh_token = "refresh token used to renew api_token"

	# Optional Azure Key Vault settings
	key_vault_name = "azure-key-vault-name"
	key_vault_user_name_secret_name = "secret-name-for-user-name"
	key_vault_password_secret_name = "secret-name-for-password"
	key_vault_api_token_secret_name = "secret-name-for-api-token"
	key_vault_refresh_token_secret_name = "secret-name-for-refresh-token"

	ignore_cert = "true/false to ignore certificate warnings for https endpoints"
}
```
## Example Usage

```
provider "commvault" {
	web_service_url = "https://webconsole.domain.com/webconsole/api"
	user_name       = "your-admin-username"
	password = "QnVebFRgciEoMg=="
	ignore_cert = true
}
```

## Azure Key Vault Usage

Use Azure Key Vault when you do not want to place credentials directly in Terraform files.

### Prerequisites

- Install Azure CLI on the machine where Terraform runs.
- Run `az login` before `terraform plan` or `terraform apply`.
- Ensure the Azure identity has Key Vault secret `get` permission.

### Provider Configuration with Key Vault

```
provider "commvault" {
	web_service_url = "https://webconsole.domain.com/webconsole/api"

	# Optional inline values. If empty, provider reads from Key Vault.
	user_name = ""
	password = ""
	api_token = ""
	refresh_token = ""

	key_vault_name = "my-kv"
	key_vault_user_name_secret_name = "commvault-user"
	key_vault_password_secret_name = "commvault-password"
	key_vault_api_token_secret_name = "commvault-api-token"
	key_vault_refresh_token_secret_name = "commvault-refresh-token"

	ignore_cert = true
}
```

### Credential Precedence

For each field (`user_name`, `password`, `api_token`, `refresh_token`):

1. Use inline provider value when non-empty.
2. Use Azure Key Vault secret when inline value is empty.

### Refresh Token Notes

- `refresh_token` is optional, but recommended when using `api_token`.
- If `api_token` is expired, provider attempts renewal using `refresh_token`.
- Store both token values in Key Vault for best operational stability.
- If renewal fails with "Renew request placed after the permissible time limit", generate a new token pair and update the Key Vault secrets.

### Required

- **web_service_url** (String) Specifies the Web Server URL of the commserver for performing Terraform Operations.

### Optional

- `password` (String) Specifies the Password for the user name to authentication to Web Server. Alternatively set CV_TER_PASSWORD environment variable for terraform to pick it.
- `user_name` (String) Specifies the User name used for authentication to Web Server.
- `api_token` (String) Specifies the access token for the user. Alternatively set CV_TER_TOKEN environment variable for terraform to pick it.
- `refresh_token` (String) Specifies refresh token used to renew access token.
- `key_vault_name` (String) Azure Key Vault name for secret lookup.
- `key_vault_user_name_secret_name` (String) Key Vault secret name for `user_name`.
- `key_vault_password_secret_name` (String) Key Vault secret name for `password`.
- `key_vault_api_token_secret_name` (String) Key Vault secret name for `api_token`.
- `key_vault_refresh_token_secret_name` (String) Key Vault secret name for `refresh_token`.
- `ignore_cert` (Bool) true/false to ignore certificate warnings for https endpoints.



## Support Matrix
| SOFTWARE VERSION  | SUPPORTED RESOURCES |
| --------  | ------------------- | 
| 11.24 |  <ul><li>commvault_plan</li><li>commvault_user</li><li>commvault_vm_group</li><li>commvault_vmware_hypervisor</li><li>commvault_amazon_hypervisor</li><li>commvault_azure_hypervisor</li><li>commvault_plan_to_vm</li><li>commvault_company</li><li>commvault_disk_storage</li><li>commvault_aws_storage</li><li>commvault_azure_storage</li><li>commvault_google_storage</li><li>commvault_install_ma</li><li>commvault_security_association</li></ul> |
| 11.28      | <ul><li>commvault_user_v2</li><li>commvault_usergroup</li><li>commvault_role</li><li>commvault_security_association_v2</li></ul> | 
| 11.30.28      | <ul><li>commvault_hypervisor_aws</li><li>commvault_hypervisor_azure</li><li>commvault_vmgroup_v2</li></ul> |
| 11.32      | <ul><li>commvault_credential_aws</li><li>commvault_credential_awswithrolearn</li><li>commvault_credential_azure</li><li>commvault_credential_azurewithtenantid</li><li>commvault_kubernetes_appgroup</li><li>commvault_kubernetes_cluster</li><li>commvault_plan_backupdestination</li><li>commvault_plan_server</li><li>commvault_storage_cloud_accesspath</li><li>commvault_storage_cloud_azure</li><li>commvault_storage_cloud_bucket_s3</li><li>commvault_storage_cloud_s3</li><li>commvault_storage_container_azure</li><li>commvault_storage_disk</li><li>commvault_storage_disk_backup_location</li><li>commvault_disk_accesspath</li></ul> |
| 11.36      | <ul><li>commvault_oracle_install_agent</li><li>commvault_oracle_instance</li><li>commvault_oracle_subclient</li></ul> |
| 11.42 (SaaS) | <ul><li>commvault_awsprotectiongroup</li><li>commvault_azureprotectiongroup</li><li>commvault_cloudconnection</li></ul> |  
 