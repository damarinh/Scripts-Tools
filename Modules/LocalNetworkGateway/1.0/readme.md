# KeyVault

This module deploys Local Network Gateway, with resource lock.

## Resources

- Microsoft.Network/localNetworkGateways
- Microsoft.Network/localNetworkGateways/providers/locks

## Parameters

| Parameter Name | Type | Default Value | Possible values | Description |
| :-             | :-   | :-            | :-              | :-          |
| `localNetworkGatewayName` | string | | | Required. Name of the Local Network Gateway
| `location` | string | `[resourceGroup().location]` | | Optional. Location for all resources.
| `localAddressPrefixes` | array | [] | | Required. List of the local (on-premises) IP address ranges
| `localGatewayPublicIpAddress` | string | "" | | Required. Public IP of the local gateway
| `localAsn` | string | "" | | Optional. The BGP speaker's ASN. Not providing this value will automatically disable BGP on this Local Network Gateway resource.
| `localBgpPeeringAddress` | string | "" | | Optional. The BGP peering address and BGP identifier of this BGP speaker. Not providing this value will automatically disable BGP on this Local Network Gateway resource.
| `localPeerWeight` | string | "" | | Optional. The weight added to routes learned from this BGP speaker. This will only take effect if both the localAsn and the localBgpPeeringAddress values are provided.
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
| `localNetworkGatewayResourceId` | The Resource Id of the Local Network Gateway.
| `localNetworkGatewayResourceGroup` | The name of the Resource Group the Local Network Gateway was created in.
| `localNetworkGatewayName` | The Name of the Local Network Gateway.

## Considerations

*N/A*

## Additional resources

- [What is VPN Gateway?](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways)
- [Use tags to organize your Azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags)