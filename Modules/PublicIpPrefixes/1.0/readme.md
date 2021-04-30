# RouteTables

This template deploys Public IP Prefixes.

## Resources

- Microsoft.Network/publicIPPrefixes
- Microsoft.Network/publicIPPrefixes/providers/locks

## Parameters

| Parameter Name | Type | Default Value | Possible values | Description |
| :-             | :-   | :-            | :-              | :-          |
| `publicIpPrefixName` | | Required. Name of the Public IP Prefix
| `location` | string | `[resourceGroup().location]` | | Optional. Location for all resources.
| `prefixLength` | int | | 28-31 | Required. Length of the Public IP Prefix
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

## Outputs

| Output Name | Description |
| :-          | :-          |
| `publicIpPrefixResourceId` | The Resource Id of the Public IP Prefix.
| `publicIpPrefixResourceGroup` | The name of the Resource Group the Public IP Prefix was created in.
| `publicIpPrefixName` | The Name of the Public IP Prefix.

## Considerations

*N/A*

## Additional resources

- [Public IP address prefix](https://docs.microsoft.com/en-us/azure/virtual-network/public-ip-address-prefix)
- [Use tags to organize your Azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags)
