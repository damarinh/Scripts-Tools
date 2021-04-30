# KeyVault

This module deploys Key Vault, with resource lock.

## Resources

- Microsoft.KeyVault/vaults
- Microsoft.KeyVault/vaults/providers/diagnosticsettings
- Microsoft.KeyVault/vaults/providers/locks
- Microsoft.KeyVault/vaults/secrets

## Parameters

| Parameter Name | Type | Default Value | Possible values | Description |
| :-             | :-   | :-            | :-              | :-          |
| `keyVaultName` | string | | | Required. Name of the Azure Key Vault
| `location` | string | `[resourceGroup().location]` | | Optional. Location for all resources.
| `accessPolicies` | object | `{}` | Complex structure, see below. | Optional. Access policies object
| `secretsObject` | object | `{}` | Complex structure, see below. | Optional. All secrets {\"secretName\":\"\",\"secretValue\":\"\"} wrapped in a secure object
| `enableVaultForDeployment` | bool | `true` | | Optional. Specifies if the vault is enabled for deployment by script or compute
| `enableVaultForTemplateDeployment` | bool | `true` | | Optional. Specifies if the vault is enabled for a template deployment
| `enableVaultForDiskEncryption` | bool | `true` | | Optional. Specifies if the azure platform has access to the vault for enabling disk encryption scenarios.
| `vaultSku` | string | `Premium` | Premium, Standard |Optional. Specifies the SKU for the vault
| `vNetId` | string | "" | | Optional. Virtual Network Identifier used to create a service endpoint.
| `networkAcls` | object | {} | Complex structure, see below. | Optional. Network ACLs, this value contains IPs to whitelist and/or Subnet information.
| `diagnosticLogsRetentionInDays` | int | `365` | | Optional. Specifies the number of days that logs will be kept for; a value of 0 will retain data indefinitely.
| `diagnosticStorageAccountId` | string | "" | | Optional. Resource identifier of the Diagnostic Storage Account.
| `workspaceId` | string | "" | | Optional. Resource identifier of Log Analytics.
| `eventHubAuthorizationRuleId` | string | "" | | Optional. Resource ID of the event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.
| `eventHubName` | string | "" | | Optional. Name of the event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category.
| `lockForDeletion` | bool | `true` | | Optional. Switch to lock Virtual Network Gateway from deletion.
| `tags` | object | {} | Complex structure, see below. | Optional. Tags of the Virtual Network Gateway resource.

### Parameter Usage: `tags`

Tag names and tag values can be provided as needed. A tag can be left without a value.

```json
"tags": {
    "value": {
        "Environment": "Non-Prod",
        "Contact": "test.user@testcompany.com",
        "PurchaseOrder": "1234",
        "CostCenter": "7890",
        "ServiceName": "DeploymentValidation",
        "Role": "DeploymentValidation"
    }
}
```

### Parameter Usage: `networkAcls`

```json
"networkAcls": {
    "value": {
        "bypass": "AzureServices",
        "defaultAction": "Deny",
        "virtualNetworkRules": [
            {
                "subnet": "sharedsvcs"
            }
        ],
        "ipRules": []
    }
}
```

### Parameter Usage: `vNetId`

```json
"vNetId": {
    "value": "/subscriptions/00000000/resourceGroups/resourceGroup"
}
```

### Parameter Usage: `accessPolicies`

```json
"accessPolicies": {
    "value": [
        {
            "tenantId": null,
            "objectId": null,
            "permissions": {
                "certificates": [
                    "All"
                ],
                "keys": [
                    "All"
                ],
                "secrets": [
                    "All"
                ]
            }
        }
    ]
}
```

### Parameter Usage: `secretsObject`

```json
"secretsObject": {
    "value": {
        "secrets": [
            {
                "secretName": "Secret--AzureAd--Domain",
                "secretValue": "Some value"
            }
        ]
    }
}
```

## Outputs

| Output Name | Description |
| :-          | :-          |
| `keyVaultResourceId` | The Resource Id of the Key Vault.
| `keyVaultResourceGroup` | The name of the Resource Group the Key Vault was created in.
| `keyVaultName` | The Name of the Key Vault.
| `keyVaultUrl` | The Name of the Key Vault.

## Considerations

*N/A*

## Additional resources

- [What is Azure Key Vault?](https://docs.microsoft.com/en-us/azure/key-vault/key-vault-whatis)
- [Microsoft.KeyVault vaults template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.keyvault/2018-02-14/vaults)
- [Use tags to organize your Azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags)