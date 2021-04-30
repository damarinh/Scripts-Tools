# VirtualNetworkGatewayConnection

This template deploys Virtual Network Gateway Connection.

## Resources

- Microsoft.Network/connections
- Microsoft.Network/connections/providers/locks

## Parameters

| Parameter Name | Type | Default Value | Possible values | Description |
| :-             | :-   | :-            | :-              | :-          |
| `connectionName` | string | | | Required. Remote connection name
| `location` | string | `[resourceGroup().location]` | | Optional. Location for all resources.
| `virtualNetworkGatewayConnectionType` | string | `Ipsec` | Ipsec, VNet2VNet, ExpressRoute, VPNClient | Optional. Gateway connection type.
| `localVirtualNetworkGatewayName` | string | | | Required. Specifies the local Virtual Network Gateway name
| `remoteEntityName`  | string | | | Required. Specifies the remote Virtual Network Gateway/ExpressRoute
| `remoteEntityResourceGroup`  | string | "" | | Optional. Remote Virtual Network Gateway/ExpressRoute resource group name. Defaults to the current resource group.
| `remoteEntitySubscriptionId` |  string | "" | | Optional. Remote Virtual Network Gateway/ExpressRoute Subscription Id. Default to the current subscription.
| `vpnSharedKey` | string | | | Required. Specifies a VPN shared key. The same value has to be specified on both Virtual Network Gateways
| `enableBgp` | bool | `false` | | Optional. Value to specify if BGP is enabled or not
| `routingWeight` | string | "" | | Optional. The weight added to routes learned from this BGP speaker.
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
| `remoteConnectionResourceGroup` | The Resource Group deployed it.
| `connectionName` | The Name of the Virtual Network Gateway Connection.
| `remoteConnectionResourceId` | The Resource Id of the Virtual Network Gateway Connection.

## Considerations

*N/A*

## Additional resources

- [Microsoft.Network connections template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2018-11-01/connections)
- [Use tags to organize your Azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags)
