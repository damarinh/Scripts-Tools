# vNet

This template deploys a Virtual Network (vNet) with 2 optional Subnets.

## Resources

- Microsoft.Network/virtualNetworks
- Microsoft.Network/virtualNetworks/providers/locks
- Microsoft.Network/virtualNetworks/providers/diagnosticsettings
- Microsoft.Network/virtualNetworks/subnet

## Parameters

| Parameter Name | Type | Default Value | Possible values | Description |
| :-             | :-   | :-            | :-              | :-          |
| `vnetName` | string | | | Required. The Virtual Network (vNet) Name.
| `location` | string | `[resourceGroup().location]` | | Optional. Location for all resources.
| `vnetAddressPrefix` | array | | | Required. An Array of 1 or more IP Address Prefixes for the Virtual Network.
| `subnets` | array | | Complex structure, see below. | Required. An Array of subnets to deploy to the Virtual Network.
| `dnsServers` | array | [] | | Optional. DNS Servers associated to the Virtual Network.
| `ddosProtectionPlanId` | string | "" | | Optional. Resource Id of the DDoS protection plan to assign the VNET to. If it's left blank, DDoS protection will not be configured. If it's provided, the VNET created by this template will be attached to the referenced DDoS protection plan. The DDoS protection plan can exist in the same or in a different subscription.
| `diagnosticLogsRetentionInDays` | int | `365` | | Optional. Specifies the number of days that logs will be kept for; a value of 0 will retain data indefinitely.
| `diagnosticStorageAccountId` | string | "" | | Optional. Resource identifier of the Diagnostic Storage Account.
| `workspaceId` | string | "" | | Optional. Resource identifier of Log Analytics.
| `eventHubAuthorizationRuleId` | string | "" | | Optional. Resource ID of the event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.
| `eventHubName` | string | "" | | Optional. Name of the event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category.
| `lockForDeletion` | bool | `true` | | Optional. Switch to lock Virtual Network Gateway from deletion.
| `tags` | object | {} | Complex structure, see below. | Optional. Tags of the Virtual Network Gateway resource.

### Parameter Usage: `vnetAddressPrefix`

The `vnetAddressPrefix` parameter accepts a JSON Array of string values containing the IP Address Prefixes for the Virtual Network (vNet).

Here's an example of specifying a single Address Prefix:

```json
"vnetAddressPrefix": {
    "value": [
        "10.1.0.0/16"
    ]
}
```

### Parameter Usage: `subnets`

The `subnets` parameter accepts a JSON Array of `subnet` objects to deploy to the Virtual Network.

Here's an example of specifying a couple Subnets to deploy:

```json
"subnets": {
    "value": [
    {
        "name": "GatewaySubnet",
        "addressPrefix": "10.0.255.0/24",
        "networkSecurityGroupName": "nsgName1",
        "routeTableName": "UdrName1",
        "serviceEndpoints": [
            {
                "service": "Microsoft.EventHub"
            },
            {
                "service": "Microsoft.Sql"
            },
            {
                "service": "Microsoft.Storage"
            },
            {
                "service": "Microsoft.KeyVault"
            }
        ]
    },
    {
        "name": "data",
        "addressPrefix": "10.1.1.0/24"
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
| `vNetResourceGroup` |The name of the Resource Group the Virtual Network was created in.
| `vNetResourceId` | The Resource id of the Virtual Network deployed.
| `vNetName` | The name of the Virtual Network deployed.
| `subnetNames` | The Names of the Subnets deployed to the Virtual Network.
| `subnetIds` | The Resource Ids of the Subnets deployed to the Virtual Network.

## Considerations

When defining the Subnets to deploy using the `subnets` parameter, the JSON format to pass it must match the Subnet object that is normally passed in to the `subnets` property of a `virtualNetwork` within an ARM Template.

The network security group and route table resources must reside in the same resource group as the virtual network.

## Additional resources

- [Microsoft.Network virtualNetworks template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2019-04-01/virtualnetworks)
- [What is Azure Virtual Network?](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview)
- [Use tags to organize your Azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags)
