# StorageAccount

This module is used to deploy an Azure Storage Account, with resource lock and the ability to deploy 1 or more Blob Containers. Optional ACLs can also be configured on the Storage Account too.

The default parameter values are based on the needs of deploying a diagnostic storage account.

## Resources

- Microsoft.Storage/storageAccounts
- Microsoft.Storage/storageAccounts/providers/locks
- Microsoft.Storage/storageAccounts/blobServices/containers

## Parameters

| Parameter Name | Type | Default Value | Possible values | Description |
| :-             | :-   | :-            | :-              | :-          |
| `storageAccountName` | string | | | Required. Name of the Storage account.
| `location` | string | `[resourceGroup().location]` | | Optional. Location for all resources.
| `storageAccountKind` | string | `StorageV2` | Storage, StorageV2, BlobStorage, FileStorage, BlockBlobStorage | Optional. Type of Storage Account to create.
| `storageAccountSku` | string | `Standard_GRS` | Standard_LRS, Standard_GRS, Standard_RAGRS, Standard_ZRS, Premium_LRS, Premium_ZRS, Standard_GZRS, Standard_RAGZRS | Optional. Storage Account Sku Name.
| `storageAccountAccessTier` | string | `Hot` | Hot, Cool | Optional. Storage Account Access Tier.
| `vNetId` | string | "" | | Optional. Virtual Network Identifier used to create a service endpoint.
| `networkAcls` | object | {} | Complex structure, see below. | Optional. Network ACLs, this value contains IPs to whitelist and/or Subnet information.
| `blobContainers` | array | [] | | Optional. Blob containers to create.
| `utcYear` | `[utcNow('yyyy')]` | Optional. Year data used to generate a SAS token. Default is the current year.
| `lockForDeletion` | bool | `true` | | Optional. Switch to lock Virtual Network Gateway from deletion.
| `tags` | object | {} | Complex structure, see below. | Optional. Tags of the Virtual Network Gateway resource.

### Parameter Usage: `blobContainers`

The `blobContainer` parameter accepts a JSON Array of object with "name" property in each to specify the name of the Blob Containers to create.

Here's an example of specifying a single Blob Container named "one":

```json
[{"name": "one"}]
```

Here's an example of specifying multiple Blob Containers to create:

```json
[{"name": "one"}, {"name": "two"}]
```

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

## Outputs

| Output Name | Description |
| :- | :- |
| `storageAccountResourceId` | The Resource id of the Storage Account.
| `storageAccountRegion` | The Region of the Storage Account. |
| `storageAccountName` | The Name of the Storage Account.
| `storageAccountResourceGroup` | The name of the Resource Group the Storage Account was created in.
| `storageAccountSasToken` | The SAS Token for the Storage Account.<br/>The SAS Token generated is set to expire 100 years from the value of the `utcYear` parameter.
| `storageAccountAccessKey` | The Access Key for the Storage Account.
| `storageAccountPrimaryBlobEndpoint` | The public endpoint of the Storage Account. |

## Considerations

This is a generic module for deploying a Storage Account. Any customization for different storage needs (such as a diagnostic or other storage account) need to be done through the Archetype.

## Additional resources

- [Introduction to Azure Storage](https://docs.microsoft.com/en-us/azure/storage/common/storage-introduction)
- [ARM Template format for Microsoft.Storage/storageAccounts](https://docs.microsoft.com/en-us/azure/templates/microsoft.storage/2018-07-01/storageaccounts)
- [Storage Account Sku Type options](https://docs.microsoft.com/en-us/dotnet/api/microsoft.azure.management.storage.fluent.storageaccountskutype?view=azure-dotnet)
- [Use tags to organize your Azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags)
