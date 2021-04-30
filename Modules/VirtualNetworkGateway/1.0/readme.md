# VirtualNetworkGateway

This module deploys a Virtual Network Gateway.

## Resources

- Microsoft.Network/virtualNetworkGateways
- Microsoft.Network/virtualNetworkGateways/providers/locks
- Microsoft.Network/virtualNetworkGateways/providers/diagnosticSettings
- Microsoft.Network/publicIPAddresses
- Microsoft.Network/publicIPAddresses/providers/locks
- Microsoft.Network/publicIPAddresses/providers/diagnosticSettings

## Parameters

| Parameter Name | Type | Default Value | Possible values | Description |
| :-             | :-   | :-            | :-              | :-          |
| `virtualNetworkGatewayName` | string | | | Required. Specifies the Virtual Network Gateway name.
| `location` | string | `[resourceGroup().location]` | | Optional. Location for all resources.
| `gatewayPipName` | array | "" | | Optional. Specifies the name of the Public IP used by the Virtual Network Gateway. If it's not provided, a '-pip' suffix will be appended to the gateway's name.
| `publicIPPrefixId` | string | "" | | Optional. Resource Id of the Public IP Prefix object. This is only needed if you want your Public IPs created in a PIP Prefix.
| `domainNameLabel` | array | [] | | Optional. DNS name(s) of the Public IP resource(s). If you enabled active-active configuration, you need to provide 2 DNS names, if you want to use this feature. A region specific suffix will be appended to it, e.g.: your-DNS-name.westeurope.cloudapp.azure.com
| `virtualNetworkGatewayType` | string | | Vpn, ExpressRoute | Required. Specifies the gateway type. E.g. VPN, ExpressRoute
| `virtualNetworkGatewaySku` | string | | Basic, VpnGw1, VpnGw2, VpnGw3, VpnGw1AZ, VpnGw2AZ, VpnGw3AZ, ErGw1AZ, ErGw2AZ, ErGw3AZ | Required. The Sku of the Gateway.
| `vpnType` | string | | PolicyBased, RouteBased | Required. Specifies the VPN type
| `vpnGatewayGeneration` | string | Generation1 | Generation1, Generation2 | Optional. Specifies the VPN GW generation. |
| `vNetId` | string | | | Required. Virtual Network resource Id
| `activeActive` | bool | `true` | | Optional. Value to specify if the Gateway should be deployed in active-active or active-passive configuration
| `enableBgp` | bool | `true` | | Optional. Value to specify if BGP is enabled or not. Needs to be false if the virtualNetworkGatewayType is ExpressRoute.
| `asn` | int | `65815` | | Optional. ASN value
| `vpnClientAddressPoolPrefix` | string | "" | | Optional. The IP address range from which VPN clients will receive an IP address when connected. Range specified must not overlap with on-premise network.
| `clientRootCertData` | string | "" | | Optional. Client root certificate data used to authenticate VPN clients.
| `clientRevokedCertThumbprint` | string | "" | | Optional. Thumbprint of the revoked certificate. This would revoke VPN client certificates matching this thumbprint from connecting to the VNet.
| `diagnosticLogsRetentionInDays` | int | `365` | | Optional. Specifies the number of days that logs will be kept for; a value of 0 will retain data indefinitely.
| `diagnosticStorageAccountId` | string | "" | | Optional. Resource identifier of the Diagnostic Storage Account.
| `workspaceId` | string | "" | | Optional. Resource identifier of Log Analytics.
| `eventHubAuthorizationRuleId` | string | "" | | Optional. Resource ID of the event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.
| `eventHubName` | string | "" | | Optional. Name of the event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category.
| `lockForDeletion` | bool | `true` | | Optional. Switch to lock Virtual Network Gateway from deletion.
| `tags` | object | {} | Complex structure, see below. | Optional. Tags of the Virtual Network Gateway resource.

### Parameter Usage: `subnets`

The `subnets` parameter accepts a JSON Array of `subnet` objects to deploy to the Virtual Network.

Here's an example of specifying a couple Subnets to deploy:

```json
"subnets": {
    "value": [
    {
        "name": "app",
        "properties": {
        "addressPrefix": "10.1.0.0/24",
        "networkSecurityGroup": {
            "id": "[resourceId('Microsoft.Network/networkSecurityGroups', 'app-nsg')]"
        },
        "routeTable": {
            "id": "[resourceId('Microsoft.Network/routeTables', 'app-udr')]"
        }
        }
    },
    {
        "name": "data",
        "properties": {
        "addressPrefix": "10.1.1.0/24"
        }
    }
    ]
}
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
| :-          | :-          |
| `virtualNetworkGatewayResourceGroup` | The Resource Group the Virtual Network Gateway was deployed.
| `virtualNetworkGatewayName` | The Name of the Virtual Network Gateway.
| `virtualNetworkGatewayId` | The Resource Id of the Virtual Network Gateway.
| `activeActive` | Shows if the VNet gateway is configured in active-active mode.

## Considerations

*N/A*

## Additional resources

- [Microsoft.Network virtualNetworkGateways template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2018-11-01/virtualnetworkgateways)
- [What is VPN Gateway?](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways)
- [ExpressRoute virtual network gateway and FastPath](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-about-virtual-network-gateways)
- [Public IP address prefix](https://docs.microsoft.com/en-us/azure/virtual-network/public-ip-address-prefix)
- [Use tags to organize your Azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags)
